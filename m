Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.152]:39448 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeKLGMc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Nov 2018 01:12:32 -0500
Date: Sun, 11 Nov 2018 21:23:21 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v6 2/2] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181111202321.GF25135@x220.localdomain>
References: <20181111155911.3604-1-sst@poczta.fm>
 <20181111155911.3604-3-sst@poczta.fm>
 <20181111170446.6f35c64c@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181111170446.6f35c64c@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On lis 11, 2018 17:04, Jonathan Cameron wrote:
> On Sun, 11 Nov 2018 16:59:11 +0100
> Slawomir Stepien <sst@poczta.fm> wrote:
> 
> > devm_* APIs are device managed and make code simpler.
> > 
> > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> Hi Slawomir,
> 
> I made the minor mod below to align this with the change I made in patch 1.
> It does close a very small window where you might unnecessary power down
> if the first command in the chain_setup function resulted in an error
> so the reset may never have been issued.  Of course you can't actually
> tell where the error occurred in that spi write.  We'll just take
> the view it's such a minor risk that we can assume the spi write has
> no side effects on failure.

Got your point here. Checked the final change and it looks OK.
Thank you for changing that and picking it.

> Thanks for persisting with this.  It looks like a good result to me.

Thank you for the persisting reviews ;)

-- 
Slawomir Stepien
