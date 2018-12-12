Return-Path: <SRS0=Gvxw=OV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E40C65BAF
	for <linux-iio@archiver.kernel.org>; Wed, 12 Dec 2018 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558F420851
	for <linux-iio@archiver.kernel.org>; Wed, 12 Dec 2018 17:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="nXFKnhUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558F420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeLLRTY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:19:24 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.155]:55567 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbeLLRTX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Dec 2018 12:19:23 -0500
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <t480s.localdomain>
Received: from t480s.localdomain (ipv4-188-121-17-172.net.internetunion.pl [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Wed, 12 Dec 2018 18:19:20 +0100 (CET)
Date:   Wed, 12 Dec 2018 18:20:05 +0100
From:   Slawomir Stepien <sst@poczta.fm>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] staging: iio: adc: ad7280a: split ad7280_attr_init()
 to more functions
Message-ID: <20181212172005.GC1738@t480s.localdomain>
References: <20181212170228.28498-1-sst@poczta.fm>
 <20181212170228.28498-3-sst@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212170228.28498-3-sst@poczta.fm>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1544635162;
        bh=bhpYgPNZijcrQ/n8u47q5r7rG3rKLcrfmkRh1OPL0Y4=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Date:From:To:Cc:
         Subject:Message-ID:References:MIME-Version:Content-Type:
         Content-Disposition:In-Reply-To:User-Agent:X-Interia-Antivirus;
        b=nXFKnhUC6o4u44hwQkPFA1fgi7ae65nOF0DTlfLM3IE885i1McJL6+QDeSISKictp
         0prdhilM+IcYF68YSlvRZi4IreKjfTnz5PiBDzMWfB0xi/Rvd9arPQ2aMjbtHpn6ZP
         eQnRpbxbVPcU1VkKmfRocsULyBQmiHFAxzvzT200=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On gru 12, 2018 18:02, Slawomir Stepien wrote:
> The ad7280_attr_init function has been split into more specific
> functions to increase the code readability.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---
> Since v1:
> * Added ad7280_init_dev_attrs function.
> * The new functions now operates on struct iio_dev_attr rather than on struct
>   ad7280_state.
> ---

Sorry about not marking this as v2 in the subject line :( I'll fix that on next
version (if that happens ;)).

-- 
Slawomir Stepien
