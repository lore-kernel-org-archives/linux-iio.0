Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A458C433EF
	for <linux-iio@archiver.kernel.org>; Tue, 19 Apr 2022 11:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242854AbiDSL6I (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351964AbiDSL5i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Apr 2022 07:57:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017EF10C0
        for <linux-iio@vger.kernel.org>; Tue, 19 Apr 2022 04:54:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8CD7B81875
        for <linux-iio@vger.kernel.org>; Tue, 19 Apr 2022 11:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAD5C385A7;
        Tue, 19 Apr 2022 11:54:51 +0000 (UTC)
Date:   Tue, 19 Apr 2022 12:54:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: IIO: Ensuring DMA safe buffers.
Message-ID: <Yl6jB5DOUy+Yqyzl@arm.com>
References: <20220419121241.00002e42@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419121241.00002e42@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Tue, Apr 19, 2022 at 12:12:41PM +0100, Jonathan Cameron wrote:
> For a long time IIO has been making assumption that ____cacheline_aligned
> was sufficient to ensure buffers were in their own cacheline and hence
> DMA safe.

As you noticed, it's not. __cacheline_aligned is meant to align to
SMP_CACHE_BYTES which is L1_CACHE_BYTES, typically smaller than
ARCH_DMA_MINALIGN.

> The above series also highlights that we can do much better anyway on some platforms
> using the new ARCH_DMA_MINALIGN (currently it's only defined for some archs but
> after that patch everyone gets it).  We should be safe to use that everywhere
> we currently force ___cachline_aligned and waste a little less space on padding
> which is always nice ;)

I guess in the meantime you can just use ARCH_KMALLOC_MINALIGN, it gives
you the DMA guarantees. Any series decoupling the two will have to
update the use. I prefer to use ARCH_DMA_MINALIGN for DMA alignment but
still discussing the best way to address the crypto code changes.

> Given we have no reports of a problem with 128 byte non DMA coherent platforms
> I don't propose to 'fix' this until we can make use of the new define
> in the above patch set.  That is going to make a mess of backporting the
> fix however.  I'm wishing we did what crypto has done and had a subsystem
> specific define for this but such is life. 

Maybe we should add a generic __dma_aligned.

> We will also want to be careful
> that we cover the rather odd sounding case of ARCH_DMA_MINALIGN < 8 given
> there are a few drivers that rely on >= 8 to ensure we can do aligned puts
> of 64 bit timestamps.

I don't think ARCH_DMA_MINALIGN should go below sizeof(long long),
that's what ARCH_KMALLOC_MINALIGN is by default, it would break other
things.

> +CC Catalin for info.  If you can sneak the first patch in your series
> in for next cycle that would be great even if the rest takes a while longer.

I'll try but we have to agree on the crypto change because keeping
CRYPTO_MINALIGN as the smaller ARCH_KMALLOC_MINALIGN risks breaking DMA
into those structures.

-- 
Catalin
