Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21537 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754306AbaISPDZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 19 Sep 2014 11:03:25 -0400
Message-ID: <541C46E0.7030704@intel.com>
Date: Fri, 19 Sep 2014 18:08:16 +0300
From: Daniel Baluta <daniel.baluta@intel.com>
MIME-Version: 1.0
To: nroyer@invensense.com, ggao@invensense.com
CC: linux-iio@vger.kernel.org
Subject: Invensense MPU6500 driver with Digital Motion Processor (DMP)
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Nathan/Ge,

I'm playing with Invensense MPU6500 device but I'm having problems
receiving data when the DPM is enabled.

I've rebased the code from 3.4 [1] on top of the latest iio git
tree. Without DMP enabled, I see interrupts arriving and I can
read data from /dev/iio:device0.

I'm using the following sequence for test:

sysfs_dev=/sys/bus/iio/devices/iio:device0

#Write dmp fw
fw_loaded=`cat ${sysfs_dev}/firmware_loaded`
if [ $fw_loaded -eq 0 ]; then
     fwtool write /bin/fw.bin
fi

#Enable accel
echo 0 > ${sysfs_dev}/buffer/enable
echo 200 > ${sysfs_dev}/sampling_frequency
echo 1 > ${sysfs_dev}/accel_fifo_enable
echo 1 > ${sysfs_dev}/accel_enable
echo 1 > ${sysfs_dev}/gyro_fifo_enable
echo 1 > ${sysfs_dev}/gyro_enable
#echo 1 > ${sysfs_dev}/master_enable

#Enable DMP
echo 1 > ${sysfs_dev}/dmp_on
echo 1 > ${sysfs_dev}/dmp_int_on
echo 1 > ${sysfs_dev}/dmp_event_int_on
echo 1 > ${sysfs_dev}/buffer/enable

cat /dev/iio\:device0

Now, the problem is that there is not interrupt triggered. Have you 
faced similar issues? Is there something wrong with the above sequence? 
 
 



thanks,
Daniel.

[1] 
https://android.googlesource.com/kernel/msm/+/android-msm-hammerhead-3.4-kk-fr2/drivers/staging/iio/imu/inv_mpu
