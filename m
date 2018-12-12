Return-Path: <SRS0=Gvxw=OV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48125C65BAF
	for <linux-iio@archiver.kernel.org>; Wed, 12 Dec 2018 17:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091B420851
	for <linux-iio@archiver.kernel.org>; Wed, 12 Dec 2018 17:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="Eokq9W7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091B420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeLLRSZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:18:25 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.155]:33096 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbeLLRSZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Dec 2018 12:18:25 -0500
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <t480s.localdomain>
Received: from t480s.localdomain (ipv4-188-121-17-172.net.internetunion.pl [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Wed, 12 Dec 2018 18:18:22 +0100 (CET)
Date:   Wed, 12 Dec 2018 18:19:06 +0100
From:   Slawomir Stepien <sst@poczta.fm>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/2] staging: iio: adc: ad7280a: split
 ad7280_channel_init() to more functions
Message-ID: <20181212171906.GB1738@t480s.localdomain>
References: <20181212170228.28498-1-sst@poczta.fm>
 <20181212170228.28498-2-sst@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212170228.28498-2-sst@poczta.fm>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1544635103;
        bh=NII9OkuAqR61b9G5x5QqrsGYVHAXtjOiimqZiPRnqD8=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Date:From:To:Cc:
         Subject:Message-ID:References:MIME-Version:Content-Type:
         Content-Disposition:In-Reply-To:User-Agent:X-Interia-Antivirus;
        b=Eokq9W7Xl09uKR70Pld7Pi7A5Gzo3psM7bIupYgzEv9bx3iNglZNp5I+dXVCd/5gv
         O1S4zkPCtdPoKcgj05YqNWPMEiDKBdu99AtqnOLKSHte5OvVY7upMbrlHKAgfHAs8Y
         u4Ec/kVibF91Q2WV/iEhN/n17xjBynHVgYrwHvjQ=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On gru 12, 2018 18:02, Slawomir Stepien wrote:
> The ad7280_channel_init function has been split into more specific
> functions to increase the code readability.
> 
> The setting of channel's scan_type.shift to 0, has been removed, since
> it is the default value.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---
> Since v1:
> * Added ad7280_init_dev_channels function.
> * New functions are now using struct iio_chan_spec rather than struct
>   ad7280_state.
> * Channel's number on device calculation has been moved to macros.
> * scan_type.shift assigned has been removed.
> ---

Sorry about not marking this as v2 in the subject line :( I'll fix that on next
version (if that happens ;)).

-- 
Slawomir Stepien
