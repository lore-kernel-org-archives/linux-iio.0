Return-Path: <SRS0=IObS=DN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F02C4363D
	for <linux-iio@archiver.kernel.org>; Tue,  6 Oct 2020 22:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB0F208C7
	for <linux-iio@archiver.kernel.org>; Tue,  6 Oct 2020 22:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602023544;
	bh=OjZnmlGKScbGmRuClpnVf6jDD+JWt2ELs3/+lLUaoWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dpKDLtbrK8scrv81ZWxSLp4lvXFRljwL9iRh4+PUzSRsJfjKVClnZte7O5kFPzmha
	 jDl0hRm+A2fqUr44/NAdcYWipVFbjQL9jtb35RUGyKY8ZUc7z6jd6433ZmqW1t5WEr
	 3Kuw/t8EHBpqIV8Pu+VvCGlt/G9pyVdWqozdC4sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgJFWcX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:32:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35063 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgJFWcX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2020 18:32:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id s66so430027otb.2;
        Tue, 06 Oct 2020 15:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q4pVc5qfRsQzlPo8ffWBk8Bb8gYNdJOQlIrMmzPDD4o=;
        b=L8B40GwyM+t5jcpBmw+I9WtWjQmP+BLndltHy5ZJUXaNlRug2Qz0XgTn3pRWwOlgTd
         3z7u1evdhif1HftZzWwn/zaHwK8wsZFsP68H1jW4xLcbpV7H2fYggaHvLu6/QPIeOBpY
         cCC55QmEnR1kZe+nBsQGuTBUFl7ZkUY9ow3jAUihJPVwmu7rjnKAN+xSC5DEKl8UeL0D
         aYW2BVgpTB1FenBkXJjCGUbNPeOj07jVbMzZTrewJGe2tlkQKPuByRNPx0SEKK19cXzH
         Ac81kbgVW93zthHNKaVFztWq7gOvTB/JfTwhqz0pAlR0wdz0uPPcoTiYyZJdBgD+f5wg
         yIUQ==
X-Gm-Message-State: AOAM530dZcOvMy6SpyWbCBeJisvIrx3/Yc2mA11gxL0PhUlllB6DmpS8
        booXad7OndkppbdyXE+9rge1uWhc4Cs6
X-Google-Smtp-Source: ABdhPJzpCY4QBkQJFBHGvXal21MdEdf5qHP2tIlvnNGjayrETuF4+p0MKJX3FsgTXu2fHZVfbnydAg==
X-Received: by 2002:a9d:3a6:: with SMTP id f35mr77929otf.345.1602023541562;
        Tue, 06 Oct 2020 15:32:21 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g11sm111928otl.12.2020.10.06.15.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:32:20 -0700 (PDT)
Received: (nullmailer pid 2976770 invoked by uid 1000);
        Tue, 06 Oct 2020 22:32:20 -0000
Date:   Tue, 6 Oct 2020 17:32:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, mario.tesi@st.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dst
 device bindings
Message-ID: <20201006223220.GA2976740@bogus>
References: <cover.1601985763.git.lorenzo@kernel.org>
 <05e4273f2544230049b2cd82c6bf1be788a8e483.1601985763.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05e4273f2544230049b2cd82c6bf1be788a8e483.1601985763.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 06 Oct 2020 14:07:42 +0200, Lorenzo Bianconi wrote:
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
