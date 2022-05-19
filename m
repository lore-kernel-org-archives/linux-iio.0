Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0154FC433EF
	for <linux-iio@archiver.kernel.org>; Thu, 19 May 2022 14:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbiESOzj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 19 May 2022 10:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiESOzh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 May 2022 10:55:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CD46BFE5
        for <linux-iio@vger.kernel.org>; Thu, 19 May 2022 07:55:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC5CBB82552
        for <linux-iio@vger.kernel.org>; Thu, 19 May 2022 14:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AD5C385AA;
        Thu, 19 May 2022 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652972132;
        bh=LdO1NcwYNkpiFXkxDN/89MwWk/kLamFCSSpT6mK/cM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LC4Ig8UY8smWEHYw/xNoj/Ys1f0I8ucR1S/NdVIWvy2RcqDdwKtPZeq0UQwkz/kwx
         vYyOkwm/jw4BgeEwsyFC/MRkPE7o2Uglfsc1Jn0ms2VmvfaPZZa+hsQfHQPQr+gO9J
         6X9LX9uKsIpz/nk0ziF5PU4nZa8S6Nc7rVH4L8KQ=
Date:   Thu, 19 May 2022 16:54:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO new device support, features and cleanup
 for 5.19
Message-ID: <YoZaEhvtxzIoZPVs@kroah.com>
References: <20220504213700.7e2b8ba5@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504213700.7e2b8ba5@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 04, 2022 at 09:37:00PM +0100, Jonathan Cameron wrote:
> The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:
> 
>   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.19a
> 
> for you to fetch changes up to eda75f8238b079a41aa11383bd47dc3297e74cb1:
> 
>   iio: ti-ads8688: use of_device_id for OF matching (2022-05-01 19:01:13 +0100)

Sorry for the delay, now pulled and pushed out.

greg k-h
