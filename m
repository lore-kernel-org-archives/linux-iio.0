Return-Path: <SRS0=1XrH=32=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44467C352A4
	for <linux-iio@archiver.kernel.org>; Thu,  6 Feb 2020 20:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F582465A
	for <linux-iio@archiver.kernel.org>; Thu,  6 Feb 2020 20:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581021971;
	bh=K8NDqL+wnhkuqE2/YRWza1zYojsPPRpIOFZACeMnDxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IMbGDMwi8zuud41iosju79kleOTkXZKTCD4MAetyaXKG9LS4BnOkhxDay2palvvab
	 i97qI+UrMt4zEBDC4Ox9gV0kLP83zk2sWX5hqtXG7/cw1XqgnhvFM1m5k1VnjqI1cu
	 BSPUZojrW6K42gJnUyKV2x8Bu7AK4P/eC2eAy6ZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgBFUqK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:46:10 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54757 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgBFUqI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 15:46:08 -0500
Received: by mail-pj1-f66.google.com with SMTP id dw13so490458pjb.4;
        Thu, 06 Feb 2020 12:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=erM7SmpwA1MKSWSGa+I6VYlqmwIja0ZXELObhSYPZBk=;
        b=Air3Vn0Ce3zJzMxfYzxNsCK02szpJ1WdLGAPc2fxpV7SQqbjCyy0d6qejI6lzz7cOY
         HWFz5OYX0WJai04dRqNMMJzUeO9IsKM1WQf7j2607WLXInXFZkbsvCQwA5K2Pgq2u1qR
         8IG4CxG6GQhEqg8F/xcXmByNsIm701QY6GFD2vNp8JTr67gPDZvqCFiEQU6lwI5ve6zA
         +6I4mWjxzo+TkaZxkv8c/xplanNK0M+88zVytdWbhnH5h+aBr/M4mwDMIEabIFisR41u
         m9f+cyKrd+V5RkctwzWj+SvamJc1NBhmtCP27ur8lsLqUUZQbC8RaZ+lLe0tZTJKRGVQ
         13AA==
X-Gm-Message-State: APjAAAWPQsV2mScrpd/moO8DUIxRj2TaTrx3111XYNBbzPRq6IXA9u3b
        SCfPsHCfxu1dRk74vZ1zsA==
X-Google-Smtp-Source: APXvYqyZXwkD06oAd7+l3Qvgat+h1H2DBe2QqzmZLIXYK1Rmzig6oGubMvw+kxxH49rcCRc5SFa3iQ==
X-Received: by 2002:a17:902:103:: with SMTP id 3mr5959123plb.34.1581021966089;
        Thu, 06 Feb 2020 12:46:06 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id f8sm154710pjg.28.2020.02.06.12.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:46:05 -0800 (PST)
Received: (nullmailer pid 23260 invoked by uid 1000);
        Thu, 06 Feb 2020 18:11:27 -0000
Date:   Thu, 6 Feb 2020 18:11:27 +0000
From:   Rob Herring <robh@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Silvan Murer <silvan.murer@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: ltc2632: expand for ltc2636 support
Message-ID: <20200206181127.GA23192@bogus>
References: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Jan 2020 14:15:47 +0100, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= wrote:
> The ltc2636 family of devices is register compatible with the ltc2636
> chips, it just features 8 instead of 2 channels.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/iio/dac/ltc2632.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
