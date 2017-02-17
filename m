Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36125 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934089AbdBQUnz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2017 15:43:55 -0500
Date: Fri, 17 Feb 2017 12:43:51 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: devicetree <devicetree@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-iio@vger.kernel.org, kernel@pyra-handheld.com,
        LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v9 0/8] drivers: touchscreen: tsc2007 and ads7846/tsc2046
 improvements (use common touchscreen bindings, pre-calibration, spi fix and
 provide iio raw values)
Message-ID: <20170217204351.GF13050@dtor-ws>
References: <cover.1482936802.git.hns@goldelico.com>
 <BB8421B2-6626-4A95-BCD0-25C4CAF30F61@goldelico.com>
 <17d2c23b-6cbb-d365-71cb-fd4d7af7c958@kernel.org>
 <B04BF50A-A54E-4CA2-BB0E-7B547D40403A@goldelico.com>
 <85077609-9A95-4DBC-BDC8-649C8692065B@goldelico.com>
 <3225CF5D-53B7-456F-8128-50BCF31ADD0F@goldelico.com>
 <751454D6-9552-48D9-91EC-37DAD7B1A576@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <751454D6-9552-48D9-91EC-37DAD7B1A576@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 15, 2017 at 03:03:07PM +0100, H. Nikolaus Schaller wrote:
> Hi Dmitry,
> 
> > Am 12.02.2017 um 16:18 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> > 
> > Hi Dmitry,
> > 
> >> Am 28.01.2017 um 19:16 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> >> 
> >> Hi Dmitry,
> >> there have been no further comments/complaints about this patch series in the last month.
> >> And it appears as if only your action is needed.
> >> 
> >> What is missing for this patch series to be finally accepted?
> > 
> > Did you find time to look into my comment on patch 1/9 and make a decision on patch 6/8?
> > 
> > Is there anything open which prohibits inclusion to (and further testing within) linux/next?
> 
> May I ask a question for my fundamental understanding of the Linux integration process.
> Maybe, I have a wrong expectation which you can clarify.
> 
> My question is how it does come that patches like
> 
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=449aa83e69ff10d77fe088eadacafe1e97937c14
> 
> appear within 2 days in linux-next, but our patch series had months of review (we are at v9)
> and there have been no further comments from the community for weeks?

Simpler patches are easy to apply, patches that have some contention
tend to get unapplied longer, as they require more consideration.

> 
> What is still missing what we can do or provide as information?

I just replied to the other email from you.

Thanks.

-- 
Dmitry
