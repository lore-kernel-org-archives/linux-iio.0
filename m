Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 30 Apr 2012 12:18:37 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@cam.ac.uk>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: add mcp4725 I2C DAC driver
In-Reply-To: <4F9E5ED3.1010400@cam.ac.uk>
Message-ID: <alpine.DEB.2.01.1204301215220.27698@pmeerw.net>
References: <1335719618-28295-1-git-send-email-pmeerw@pmeerw.net> <1335719618-28295-2-git-send-email-pmeerw@pmeerw.net> <4F9E5ED3.1010400@cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

> Mostly fine.   As I explain below you were a little unlucky in which driver to
> base on.  Roland's driver is lovely and clean, but is lagging a bit in interface
> terms.

thank you for your comments!
I'll see if I understand the chan_spec interface enough

so the plan is to have part of iio in staging and the other part (core) 
in 3.5? and I can submit a driver to go in one or the other?

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
