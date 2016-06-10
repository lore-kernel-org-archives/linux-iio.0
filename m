Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50974 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932198AbcFJP1k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2016 11:27:40 -0400
Message-ID: <1465572452.7409.41.camel@hadess.net>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
From: Bastien Nocera <hadess@hadess.net>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Grant Likely <grant.likely@secretlab.ca>
Cc: Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	chaya.golan@intel.com, daniel.drubin@intel.com,
	Darren Hart <darren@dvhart.com>
Date: Fri, 10 Jun 2016 17:27:32 +0200
In-Reply-To: <1465572227.24319.7.camel@linux.intel.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>	
	 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>	
	 <1465509287.24319.3.camel@linux.intel.com>	
	 <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>	
	 <1465566904.10525.11.camel@linux.intel.com>	
	 <1465568791.7409.38.camel@hadess.net>	
	 <1465569941.10525.17.camel@linux.intel.com>	
	 <1465571076.7409.39.camel@hadess.net>
	 <1465572227.24319.7.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2016-06-10 at 08:23 -0700, Srinivas Pandruvada wrote:
> On Fri, 2016-06-10 at 17:04 +0200, Bastien Nocera wrote:
> > > 
> 
> [...]
> 
> > Are there any errors when setting the triggers?
> > 
> Is there any debug option in this service to give more verbose
> output?

Add:
Environment="G_MESSAGES_DEBUG=all"

To the service file. You should see the debug in systemctl:
systemctl status iio-sensor-proxy.service

Or in journalctl if there's too much data:
journalctl --reverse -u iio-sensor-proxy.service

Cheers
