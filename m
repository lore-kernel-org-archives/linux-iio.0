Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1473793566.6874.10.camel@linux.intel.com>
Subject: Re: possible odd acceleration scaling
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, rrs@researchut.com,
	linux-iio@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Date: Tue, 13 Sep 2016 12:06:06 -0700
In-Reply-To: <d275ff67-4335-a6f4-b60b-c4227a59b34c@kernel.org>
References: <1473787814.8047.8.camel@researchut.com>
	 <a9078c9f-0d07-35bc-e449-2cfeee7b7987@kernel.org>
	 <d275ff67-4335-a6f4-b60b-c4227a59b34c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Tue, 2016-09-13 at 19:01 +0100, Jonathan Cameron wrote:
> On 13/09/16 18:50, Jonathan Cameron wrote:
> > 
> > On 13/09/16 18:30, Ritesh Raj Sarraf wrote:
> > > 
> > > Hello Srinivas and Others,
> > > 
> > > [Please CC me in replies. I'm not subscribed to the list]
> > > 
> > > This email is in regard to an odd behavior, we seems to have
> > > discovered with
> > > iio-sensor-proxy version 1.2 and the iio driver in Linux, maybe
> > > particular to
> > > the following driver.
> > > 
> > > 
> > > rrs@learner:~$ lsusb 
> > > Bus 003 Device 002: ID 8087:8000 Intel Corp. 
> > > Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > > Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> > > Bus 001 Device 006: ID 048d:8350 Integrated Technology Express,
> > > Inc. 
> > > Bus 001 Device 005: ID 0bda:b728 Realtek Semiconductor Corp. 
> > > Bus 001 Device 004: ID 04f2:b40f Chicony Electronics Co., Ltd 
> > > Bus 001 Device 003: ID 04f3:0303 Elan Microelectronics Corp. 
> > > Bus 001 Device 002: ID 0bda:0129 Realtek Semiconductor Corp.
> > > RTS5129 Card Reader
> > > Controller
> > > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > > 2016-09-13 / 22:56:58 ♒♒♒  ☺  
> > > 
> > > 
> > > rrs@learner:/sys/devices/pci0000:00/0000:00:14.0/usb1/1-8/1-
> > > 8:1.0/0003:048D:8350.0002/HID-SENSOR-200073.4.auto$ find
> > > iio\:device2/ -iname
> > > "*scale*" -print -exec cat '{}' \;
> > > iio:device2/in_accel_scale
> > > 0.009806
> > Looking at your bug report, raw readings are around magnitude 1000.
> > 1000*0.009806 = 9.81
Which seems is correct value after scale for atleast one of the axis.

I think again we have issue with the channel index.
>From logs

** (process:10579): DEBUG: No new data available on 'iio:device3'
** (process:10579): DEBUG: process_scan_1: channel_index: 2, chan_name:
in_accel_x, channel_data_index: 0 location: 8
** (process:10579): DEBUG: process_scan_1: channel_index: 1, chan_name:
in_accel_y, channel_data_index: 1 location: 4
** (process:10579): DEBUG: process_scan_1: channel_index: 0, chan_name:
in_accel_z, channel_data_index: 2 location: 0


** (process:10579): DEBUG: Read from IIO on 'iio:device0': -230, -968,
23
** (process:10579): DEBUG: Accel sent by driver (quirk applied): 2, 9,
0


Again somehow we think that X is at byte index 8, Y at byte index 4,
and Z at byte index 8. Looks like it got reversed.
It should be 0, 4 and 8 respectively.

Can you try reverting this commit in iio-sensor-proxy? If it is then
this is some indexing issue we still need to address:

"buffer-utils: Fix orientation axis switch using 4.8 kernel"

Thanks,
Srinivas






> > 
> > Given accelerations in IIO are in m/s^2 I'm slightly confused...


> > 
> > Guessing the iio-sensor-proxy might be getting it's idea of what
> > counts
> > as orientation from the wrong place?  
> > 
> > I couldn't immediately see where it figures that out...
> Ah, found it. In orientation.c (obvious I guess)
> 
> Too late in the day here for me to spot exactly why the rounding
> errors being introduced are resulting in this concluding that
> the orientation isn't changing significantly.
> 
> Perhaps stick a line in the sensor proxy to spit out the
> computed 'rotation' value?
> 
> Thanks,
> 
> Jonathan
> > 
> > 
> > Jonathan
> > 
> > > 
> > > 2016-09-13 / 22:37:29 ♒♒♒  ☺  
> > > 
> > > 
> > > Machine: Lenovo Yoga 2 13.
> > > 
> > > 
> > > For a background, please have a look at the github bug report.
> > > https://github.com/hadess/iio-sensor-proxy/issues/100
> > > 
> > > 
> > > If you need any information, please let me know. I'm not sure
> > > what other
> > > information to provide upfront, that maybe be relevant.
> > > 
> > > 
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
