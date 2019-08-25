Return-Path: <SRS0=19IN=WV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D447C41514
	for <linux-iio@archiver.kernel.org>; Sun, 25 Aug 2019 18:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02EE21848
	for <linux-iio@archiver.kernel.org>; Sun, 25 Aug 2019 18:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566756677;
	bh=UUK7tEQ+rTb3ouj3U8uBFsbnz05fBk4q02q+1HY4H2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=m9gyslfBhO2u4R/8Bb1ZhRhRmu1CvGqN4OoBFKwcBn06D4NnP3/mAZgfhhCwfwbMq
	 WM8bUpG7z5Mj82dMniiiWOkznmg8w6UF/UwU4ar1mbKr9RSBiZhW92vvte4pTmQUJb
	 HPcsL01tQmxsCKtJrhwXtnWLbf0CZt1AzxeTfbks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfHYSLQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbfHYSLQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Aug 2019 14:11:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF506206E0;
        Sun, 25 Aug 2019 18:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566756675;
        bh=UUK7tEQ+rTb3ouj3U8uBFsbnz05fBk4q02q+1HY4H2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1BSb1L20mqSuNK19ws+uDZPDUpe6dsgXXuSXqp31wZFFF2cIYxsJWBdOeITMLgjmc
         4BcwXhSSjihImkjTenXfztO5PReV9tr0bc8uOeI+tWFtTPXYW+r8wv31JUbqrDBNR7
         bqZva5MwxgJ3wlUA2tg9hb6/tmfLFQruv6rmdNw4=
Date:   Sun, 25 Aug 2019 19:11:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Simon Horman <horms+renesas@verge.net.au>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: light: isl29501: Rename bindings
 documentation file
Message-ID: <20190825191109.510e91b5@archlinux>
In-Reply-To: <20190819141708.20456-1-horms+renesas@verge.net.au>
References: <20190819141708.20456-1-horms+renesas@verge.net.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 19 Aug 2019 16:17:08 +0200
Simon Horman <horms+renesas@verge.net.au> wrote:

> Rename the bindings documentation file for Renesas ISL29501 Time-of-flight
> sensor from isl29501.txt to renesas,isl29501.txt.
> 
> This is part of an ongoing effort to name bindings documentation files for
> Renesas IP blocks consistently, in line with the compat strings they
> document.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied,

Thanks,

Jonathan

> ---
> Based on v5.3-rc1
> 
> v2
> * Drop spurious top-level Makefile hunk
> ---
>  .../devicetree/bindings/iio/light/{isl29501.txt => renesas,isl29501.txt}  | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/iio/light/{isl29501.txt => renesas,isl29501.txt} (100%)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/isl29501.txt b/Documentation/devicetree/bindings/iio/light/renesas,isl29501.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/iio/light/isl29501.txt
> rename to Documentation/devicetree/bindings/iio/light/renesas,isl29501.txt

