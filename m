Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 17 Nov 2014 16:25:42 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Vlad Dogaru <vlad.dogaru@intel.com>
cc: linux-iio@vger.kernel.org, jic23@kernel.org, mranostay@gmail.com
Subject: Re: [PATCH 0/2] iio: driver for Semtech SX9500
In-Reply-To: <1416237169-10707-1-git-send-email-vlad.dogaru@intel.com>
Message-ID: <alpine.DEB.2.02.1411171622140.3424@pmeerw.net>
References: <1416237169-10707-1-git-send-email-vlad.dogaru@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> The device does not estimate distance, it only outputs a single bit which
> indicates proximity.  We use 0 to mean that an object is close and 1 otherwise,
> sort of an uncalibrated distance.  From what I understand in the ABI
> specification, this is allowed.

perhaps the input subsystem would be a better fit for this driver/device?
what is it typically used for?

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
