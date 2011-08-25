Return-Path: <malas@tcoe.iitm.ac.in>
From: "malas" <malas@tcoe.iitm.ac.in>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: ad7793 adc rcv userspace test - details attached
Date: Thu, 25 Aug 2011 12:28:01 +0530
Message-Id: <20110825065114.M64516@tcoe.iitm.ac.in>
In-Reply-To: <4E551DEF.4030805@cam.ac.uk>
References: <20110824081952.M29386@tcoe.iitm.ac.in> <4E54B9D0.20903@cam.ac.uk> <20110824084734.M61257@tcoe.iitm.ac.in> <4E551DEF.4030805@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Wed, 24 Aug 2011 16:51:11 +0100, Jonathan Cameron wrote
> On 08/24/11 09:53, malas wrote:
> > On Wed, 24 Aug 2011 09:44:00 +0100, Jonathan Cameron wrote
> >> On 08/24/11 09:26, malas wrote:
> >>>
> >>> Dear Michael Hennerich,
> >>>
> >>> I have attached the details of my testing with the ad7793 driver both as when
installed
> >>> as module and otherwise.
> >>>
> >>> I have not been to resolve the issue even after having created a device node under
/dev
> >>> as device0:buffer0.
> >>>
> >>> Requesting your further assistance for the same.
> >>>
> >>> Thanks
> >>> Mala
> >>>
> >>>
> >>>
> >>> --
> >>> Open WebMail Project (http://openwebmail.org)
> >>>
> >>>
> >>>
> >>
> >>> Testing results of ADC ad7793 driver with generic_buffer.c
> >>>
> >>>
> >>> Results of installing ad7793 adc driver as module:
> >>>
> >>> root:/> cd lib/modules/3.1.0-rc1-dirty/kernel/drivers/staging/iio/adc/ 
> >>> root:/lib/modules/3.1.0-rc1-dirty/kernel/drivers/staging/iio/adc> ls ad7793.ko 
> >>> root:/lib/modules/3.1.0-rc1-dirty/kernel/drivers/staging/iio/adc> insmod ad7793. ko 
> >>> ad7793: module is from the staging directory, the quality is unknown, you have been
> > warned. 
> >>> root:/lib/modules/3.1.0-rc1-dirty/kernel/drivers/staging/iio/adc> lsmod 
> >>> Module                  Size  Used by 
> >>> ad7793                  7998  0 
> >>> root:/lib/modules/3.1.0-rc1-dirty/kernel/drivers/staging/iio/adc> cd 
> >>> root:/> ls -l /dev/device0\:buffer0 
> >>> crw-r--r--    1 root     root        0,   0 Jan  1 00:00 /dev/device0:buffer0 
> >>> root:/> ls /sys/bus/iio/devices/ 
> >>> iio_sysfs_trigger 
> >>> root:/> 
> >>>
> >>> I observed driver probe() doesn't get called when inserted as module. Also the
> > device0\buffer0 nodes dont get created on installation.
> >>
> >> If probe isn't getting called then something has gone wrong in device matching.
> >> What is the board file you are using? (guessing blackfin hasn't gone all 
> >> device tree yet?)
> > 
> >   board file and driver has name and modalias as ad7793 (small case)
> > 
> > 
> >>
> >>> Results of installing ad7793 adc driver built into kernel:
> >>>
> >>> I added following line in .rc under dist/vendor/AnalogDevices/common/. 
> >>>
> >>> mknod /dev/device0:buffer0 c 0 0
> >>>
> >>> Please confirm this property of node is correct?
> >>
> >> No it isn't. 
> >> http://www.kernel.org/pub/linux/docs/device-list/devices-2.6+.txt
> >> tells us that 0 0 is reserved for null devices.
> > 
> > iio major number listed under/proc/devices for iio was 254  
> > What major and minor number should I initialize for the /dev/devicw0buffer0 device
node. 
> Major as you've noted is 255
> > 
> > 
> >> What does the following contain?
> >>
> >> /sys/bus/iio/devices/device0:/buffer0/dev
> > 
> > It has ad7793-dev
> really?  Should be a major:minor number pair.
Sorry, that was trigger name. Under /dev, as you say,

Yes Jonanthan. /dev has  major:minor = 254:0.

Open() call now succeeds. Poll waits indefinitely. I have to check out if "data ready"
signalling GPIO interrupt gets enabled and ring buffer getting filled or not.I shall
test further and get back.

Thanks Jonanthan.



> > --
> > Open WebMail Project (http://openwebmail.org)
> > 
> > 
> > 
> >


--
Open WebMail Project (http://openwebmail.org)
