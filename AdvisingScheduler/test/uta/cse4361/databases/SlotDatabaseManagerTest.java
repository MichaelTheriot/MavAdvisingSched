/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.databases;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import org.junit.AfterClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.BeforeClass;
import uta.cse4361.businessobjects.Slot;
import uta.cse4361.businessobjects.AppointmentSlot;
import uta.cse4361.businessobjects.AvailableSlot;
import uta.cse4361.businessobjects.SlotFactory;

/**
 *
 * @author Frank R.
 */
public class SlotDatabaseManagerTest implements uta.cse4361.interfaces.Constants{
    
    public SlotDatabaseManagerTest() {
    }
    
    private Date currentDate;
    @Before
    public void setUp()
    {
        currentDate = new Date();
        File dataFile = new File(FDB_FILE_NAME);
        dataFile.delete();
    }
    
    @BeforeClass
    public static void beforeClass()
    {
        /*
        File dataFile = new File(FlyweightDatabaseManager.FDB_FILE_NAME);
        File tempDataFile = new File("backup_FDB_file");
        
        tempDataFile.delete();
        
        if(dataFile.exists())
        {
            if(!dataFile.renameTo(tempDataFile))
            {
                fail();
            }
        }
        */
    }
    
    @AfterClass
    public static void afterClass()
    {
        /*
        File dataFile = new File(FlyweightDatabaseManager.FDB_FILE_NAME);
        File tempDataFile = new File("backup_FDB_file");
        
        if(tempDataFile.exists())
        {
            if(!tempDataFile.renameTo(dataFile))
            {
                fail();
            }
        }
        
        File toDelete = new File("backup_FDB_file");
        toDelete.delete();
        */
    }

    private ArrayList<Slot> createAvailableFlyweights(int startTime, int endTime, int hour)
    {
        ArrayList<Slot> flyweights = new ArrayList<Slot>();
        
        for(int i = startTime; i < endTime; 
                i = i + INCREMENT_GAP)
        {
            AvailableSlot af = new AvailableSlot(currentDate, hour, i);
            flyweights.add(af);
        }
        return flyweights;
    }
    
    private ArrayList<Slot> createAppointmentFlyweights(int startTime, int endTime, int hour)
    {
        ArrayList<Slot> flyweights = new ArrayList<Slot>();
        
        for(int i = startTime; i <= endTime; 
                i = i + INCREMENT_GAP)
        {
            AppointmentSlot af = new AppointmentSlot(VALID_ID, currentDate, hour, i);
            flyweights.add(af);
        }
        return flyweights;
    }
    
    @Test
    public void addFlyweightsTest()
    {
        SlotDatabaseManager fdb = new SlotDatabaseManager();
        
        ArrayList<Slot> flyweights = createAvailableFlyweights(MIN_MINUTE, MIN_MINUTE + 45, MIN_HOUR);
        
        String result = fdb.saveFlyweights(flyweights);
        assertEquals("Did not get valid return from saving", "", result);
        
        fdb = null;
        
        fdb = new SlotDatabaseManager();
        
        ArrayList<Slot> savedFlyweights = fdb.getDaysFlyweights(currentDate);
        
        assertEquals("The number of flyweights saved and returned deviated.", flyweights.size(), savedFlyweights.size());

    }  
    
    @Test
    public void addMixedFlyweightsTest()
    {
        SlotDatabaseManager fdb = new SlotDatabaseManager();
        
        ArrayList<Slot> availableFlys = createAvailableFlyweights(MIN_MINUTE, MIN_MINUTE + 45, MIN_HOUR);
        
        String result = fdb.saveFlyweights(availableFlys);
        assertEquals("Did not get valid return from saving", "", result);
        
        ArrayList<Slot> appointmentFlys = createAppointmentFlyweights(MIN_MINUTE, MIN_MINUTE + 15, MIN_HOUR);
        
        fdb.saveFlyweights(appointmentFlys);
        
        fdb = null;
        
        fdb = new SlotDatabaseManager();
        
        ArrayList<Slot> savedFlyweights = fdb.getDaysFlyweights(currentDate);
        
        assertEquals("The FDB did not return the same number of flyweights as availableFlyweights were created.", availableFlys.size(), savedFlyweights.size());
        
        for(int i = 0; i < availableFlys.size(); i++)
        {
            if (i < appointmentFlys.size())
            {
                assertEquals("The FDB did not return an appointmentFlyweight as the member", true, savedFlyweights.get(i).isAppointment());
            }
            else
            {
                assertEquals("The FDB did not return an availableFlyweight as the  member", false, savedFlyweights.get(i).isAppointment());
            }
        }
        
        



    } 
    
    @Test
    public void isFreeValidTest()
    {
        SlotDatabaseManager fdb = new SlotDatabaseManager();
        
        ArrayList<Slot> availableFlys = createAvailableFlyweights(MIN_MINUTE, MIN_MINUTE + 45, MIN_HOUR);
        
        String result = fdb.saveFlyweights(availableFlys);
        assertEquals("Did not get valid return from saving", "", result);
        
        boolean free = fdb.isFree(currentDate, MIN_HOUR + 1, MIN_HOUR + 1, MIN_MINUTE, MIN_MINUTE + 45);
        
        assertEquals("The time that should be free was shown as not free.", true, free);
    }
    
    @Test
    public void isFreeInvalidTest()
    {
        SlotDatabaseManager fdb = new SlotDatabaseManager();
        
        ArrayList<Slot> appointmentFlys = createAppointmentFlyweights(MIN_MINUTE, MIN_MINUTE + 45, MIN_HOUR);
        
        String result = fdb.saveFlyweights(appointmentFlys);
        assertEquals("Did not get valid return from saving", "", result);
        
        boolean free = fdb.isFree(currentDate, MIN_HOUR, MIN_HOUR, MIN_MINUTE, MIN_MINUTE + 45);
        
        assertEquals("The time that should not be free was shown as  free.", false, free);
    }
    
    @Test
    public void getDatesFreeTest()
    {
        SlotDatabaseManager fdb = new SlotDatabaseManager();
        
        ArrayList<Slot> availableFlys = createAvailableFlyweights(MIN_MINUTE, MIN_MINUTE + 45, MIN_HOUR);
        
        String result = fdb.saveFlyweights(availableFlys);
        assertEquals("Did not get valid return from saving", "", result);
        
        ArrayList<Date> dates = fdb.getDatesForAvailability();
        
        assertEquals("There is only one available date", 1, dates.size());
        
    }
    
    @Test
    public void emptyFlyweightsTest()
    {
        SlotDatabaseManager fdb = new SlotDatabaseManager();
        
        ArrayList<Slot> availableFlys = new ArrayList<Slot>();
        
        String result = fdb.saveFlyweights(availableFlys);
        assertEquals("The error message did not indicate the list was empty", FLYWEIGHTS_EMPTY_FAULT, result);
        
        availableFlys = null;
        
        result = fdb.saveFlyweights(availableFlys);
        assertEquals("The error message did not indicate the list was empty", FLYWEIGHTS_EMPTY_FAULT, result);
        
    }
    
    @Test
    public void badDateFlyweights()
    {
        SlotDatabaseManager fdb = new SlotDatabaseManager();
        
        ArrayList<Slot> availableFlys = createAvailableFlyweights(MIN_MINUTE, MIN_MINUTE + 45, MIN_HOUR);
        
        availableFlys.add(new AvailableSlot(new Date(5, 5, 5), MIN_MINUTE, MIN_HOUR));
        
        String result = fdb.saveFlyweights(availableFlys);
        assertEquals("The error message did not indicate the list had different days", FLYWEIGHTS_DIFFERENT_DATE_FAULT, result);
    }
    
    @Test
    public void getEmptyFlyweightList()
    {
        SlotDatabaseManager fdb = new SlotDatabaseManager();
        
        ArrayList<Slot> savedFlyweights = fdb.getDaysFlyweights(currentDate);
        
        assertEquals("The list should be empty", 0, savedFlyweights.size());
    }
    
}