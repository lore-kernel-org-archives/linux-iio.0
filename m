Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1465572227.24319.7.camel@linux.intel.com>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Bastien Nocera <hadess@hadess.net>, Grant Likely
 <grant.likely@secretlab.ca>
Cc: Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, Jonathan
 Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org"
 <linux-input@vger.kernel.org>,  linux-iio@vger.kernel.org, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, chaya.golan@intel.com,
 daniel.drubin@intel.com,  Darren Hart <darren@dvhart.com>
Date: Fri, 10 Jun 2016 08:23:47 -0700
In-Reply-To: <1465571076.7409.39.camel@hadess.net>
References: 
	<1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>
	 <1465509287.24319.3.camel@linux.intel.com>
	 <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>
	 <1465566904.10525.11.camel@linux.intel.com>
	 <1465568791.7409.38.camel@hadess.net>
	 <1465569941.10525.17.camel@linux.intel.com>
	 <1465571076.7409.39.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Fri, 2016-06-10 at 17:04 +0200, Bastien Nocera wrote:
> > 

[...]

> Are there any errors when setting the triggers?
> 
Is there any debug option in this service to give more verbose output?


> The code there is probably a bit naive, but I'd rather fix that
> rather
> than postpone the start of the daemon.
Agree, we shouldn't postpone. 

Thanks,
Srinivas

> 
> > 
> > After=multi-user.target, is not the ideal solution as it is too
> > late.
> > So need further debug.
> > 
> > > 
> > > 
> > > See also https://github.com/hadess/iio-sensor-proxy/issues/82
> > > 
> > > > 
> > > > > 
> > > > > I'll also take some time and review the patch series later
> > > > > this
> > > > > afternoon.
> > > > Atri Bhattacharya reported issues with suspend/resume. With my
> > > > test
> > > > patches it is fixed for him
> > > > 
> > > > If you want to hold on, I will repost with fixes for
> > > > susend/resume.
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
