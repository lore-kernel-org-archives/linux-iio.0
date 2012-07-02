Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 2 Jul 2012 14:52:38 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: Introduce iio_validate_scan_mask_onehot
In-Reply-To: <1341233083-8765-2-git-send-email-lars@metafoo.de>
Message-ID: <alpine.DEB.2.01.1207021451180.26435@pmeerw.net>
References: <1341233083-8765-1-git-send-email-lars@metafoo.de> <1341233083-8765-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Add a helper function for validating a scan mask for devices where at most one
> channel may be selected at a time. This is a common case among devices which
> have scan mask restrictions so it makes sense to provide this function in the
> core.

personally, would find iio_validate_scan_mask_atmost_one clearer than
iio_validate_scan_mask_onehot, but it is a bit longer also

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
