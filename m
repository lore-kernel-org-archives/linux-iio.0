Return-Path: <pmeerw@pmeerw.net>
Date: Thu, 26 Feb 2015 00:11:08 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Martin Fuzzey <mfuzzey@parkeon.com>
cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH V3 0/9] iio: mma8452 enhancements
In-Reply-To: <20150219141553.27001.18825.stgit@localhost>
Message-ID: <alpine.DEB.2.02.1502260009570.6800@pmeerw.net>
References: <20150219141553.27001.18825.stgit@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> This series adds some additional features to the mma8452 accelerometer driver
> 	* debugfs register access
> 	* transient threshold events
> 	* highpass filter
> 	* interrupt driven sampling (trigger)
> 	* self test mode

looks good except some very minor things;
great to see the code is used and enhanced
 
> Attributes are added to the core for:
> * highpass filter for readings
> * both high and lowpass filters for events
> 
> In addition a latent bug in the device initialisation is fixed.
> 
> V3 changes:
> 	Use 3db frequency for filter enable / disable (0=disable)
> 	Support enabling filter for readings in addition to events
> 	Use IIO_EV_INFO_PERIOD rather than custom attribute
> 	Use devm_iio_trigger_alloc()
> 	Add comment to explain irq activation during probe()
> 	iio_device_register() only after all setup
> 	Drop iio_push_event() wrapper
> 	Correct parameters to iio_push_event()
> 	Document missing attributes
> 	Add self test mode
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
