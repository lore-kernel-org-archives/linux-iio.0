Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:24048 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbcAUTr1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2016 14:47:27 -0500
Date: Thu, 21 Jan 2016 22:46:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Matt Ranostay <mranostay@gmail.com>
Cc: "Gujulan Elango, Hari Prasath (H.)" <hgujulan@visteon.com>,
	"daniel.baluta@intel.com" <daniel.baluta@intel.com>,
	"ciorneiioana@gmail.com" <ciorneiioana@gmail.com>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"hamohammed.sa@gmail.com" <hamohammed.sa@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] staging: iio: replace clk_get() with devm_clk_get()
Message-ID: <20160121194651.GA5325@mwanda>
References: <20160121091238.GA9430@IND12F0122>
 <CAKzfze_t39zoDv16ng04NpVLW1PG3n5WtCnvVp=Amh4EKme2FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKzfze_t39zoDv16ng04NpVLW1PG3n5WtCnvVp=Amh4EKme2FA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jan 21, 2016 at 11:21:53AM -0800, Matt Ranostay wrote:
> > @@ -356,8 +356,6 @@ static int spear_adc_probe(struct platform_device *pdev)
> >
> >  errout3:
> >         clk_disable_unprepare(st->clk);
> 
> Shouldn't errout3 now be errout2.. having a gap would seem odd.
> 
> > -errout2:
> > -       clk_put(st->clk);
> >  errout1:
> >         iounmap(st->adc_base_spear6xx);

GW-BASIC style numbered gotos are nonsense.  Label names should be name
after what the label does.

err_unprepare:
err_put:
err_iounmap:

But that's something for a different patch, not related to this patch.

regards,
dan carpenter

