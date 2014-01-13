Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 2/3] iio: mxs-lradc: fix invalid channel number detection
Date: Mon, 13 Jan 2014 21:25:37 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1389628923-8689-1-git-send-email-alexandre.belloni@free-electrons.com> <1389628923-8689-3-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1389628923-8689-3-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201401132125.37243.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Monday, January 13, 2014 at 05:02:02 PM, Alexandre Belloni wrote:
> 16 would be accepted as a channel number but it is invalid. It doesn't
> really have any effect as mxs_lradc_read_raw is called from a "controlled"
> environment so it it only gets values going from 0 to 15.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Why don't you remove the check entirely then ?

Best regards,
Marek Vasut
