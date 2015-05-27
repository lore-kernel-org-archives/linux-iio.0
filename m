Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44047 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbbE0EGt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 27 May 2015 00:06:49 -0400
Message-ID: <556542CB.80106@ti.com>
Date: Wed, 27 May 2015 09:36:35 +0530
From: Vignesh R <vigneshr@ti.com>
MIME-Version: 1.0
To: Michael Welling <mwelling@ieee.org>,
	"Cooper Jr., Franklin" <fcooper@ti.com>
CC: "Griffis, Brad" <bgriffis@ti.com>, "Balbi, Felipe" <balbi@ti.com>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"wsa@the-dreams.de" <wsa@the-dreams.de>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"GWilson@sakuraus.com" <GWilson@sakuraus.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: AM335x touchscreen issues
References: <20150526181157.GA8009@deathray> <20150526183713.GU26599@saruman.tx.rr.com> <20150526205310.GA2104@deathray> <8F29D6B095ED194EA1980491A5E029710C89C445@DFLE08.ent.ti.com> <20150526212851.GA12224@deathray> <8F29D6B095ED194EA1980491A5E029710C89C4E0@DFLE08.ent.ti.com> <912A29987EAE174BA6CF187D7CDFA9CE270A8C43@DLEE08.ent.ti.com> <20150526215049.GC12224@deathray> <8F29D6B095ED194EA1980491A5E029710C89C70D@DFLE08.ent.ti.com> <20150526230649.GB24948@deathray>
In-Reply-To: <20150526230649.GB24948@deathray>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Michael,

On Wednesday 27 May 2015 04:36 AM, Michael Welling wrote:
> On Tue, May 26, 2015 at 10:31:32PM +0000, Cooper Jr., Franklin wrote:
>>

[snip]

> 
> Perhaps there is coupling between the LCD lines and the ADC lines?

On Beaglebone Black with BB-View 4.3" Cape from Farnell, the LCD lines
and TSCADC lines are placed close to one another, hence the analog
signals are affected by digital LCD signals, leading to above issue.

This was reported when I submitted the patches in question. Please see
http://thread.gmane.org/gmane.linux.kernel.iio/14710/focus=121321
http://thread.gmane.org/gmane.linux.kernel.iio/14710/focus=15242

I did document this in my cover letter. Please see
http://thread.gmane.org/gmane.linux.kernel.iio/15583

I think its the same issue that you are facing.

Regards
Vignesh
