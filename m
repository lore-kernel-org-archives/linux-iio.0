Return-Path: <SRS0=9pL2=YI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD573ECE58F
	for <linux-iio@archiver.kernel.org>; Tue, 15 Oct 2019 20:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A302220873
	for <linux-iio@archiver.kernel.org>; Tue, 15 Oct 2019 20:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571171643;
	bh=hCUhOtxbSZlQyUxGOBdgDfrKzp4NCgCKDFzHGsWUVgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R+kwJGlcpquZlsiyUzS4G1v828OiWFSkaXWdu/xpp7amPhLlmmsb7sMk1eUltE3bm
	 2VssGJ8EhmYCbEdLEFjWE71K2/jjru9UAX93YI6Syex76PjHt37PsaQIGxJsfHmeIZ
	 Hp326mxascGj0PG6+b0BOMzDtbtAk1zfgu3uO1Wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbfJOUeD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:34:03 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32848 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbfJOUeD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 16:34:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id a15so18062851oic.0;
        Tue, 15 Oct 2019 13:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=momjIFO0lgXJzooic5QXjfuW8VzSzlu4LDVeHEPwLxo=;
        b=SS7uQYLEYz3DPasdqjtmdeAKobOkqRR8oOs/G6O0DiLmoG+Q3LXsiL0YF8mhI6KVeW
         gcouwqjoP+0HtVA5nz00NUfSsHGp+rR0reN4zJ1mfs3FrOyEhb5qEo8xxYQF/R19ty6e
         YhQb+p9ft4vD3bzrZo2/TgBFCbM9tNyGFnZ4w8FeqXzbktD6MiyWffjMSY05jmMpUW8v
         qwZODCRUDcibjBBn2Uqf2P8k5yXq1AulbcXbHLC3ODgrT+D9+oDLIO9DoB+VWastZsgX
         B1+rW40R/QdLjUK/bmEweIb78OtNsnJE2tUlyf2/QsfEt3Ga25Zg2+GmGmsm+WcR6QUQ
         KlrQ==
X-Gm-Message-State: APjAAAVNL/qdOstVE6gbgLzRqW3YDHSAAb4y/aKQRMAAuMNqwu7edNHi
        Z8W4f3faaR2Y2No8pmBexA==
X-Google-Smtp-Source: APXvYqyE5ATjyR1hAAcfQBPHThRHVE7/AYHhZqIFJo6QhyfXn4nmNjwKd/lbWDyKfK7lWt3avWGRvw==
X-Received: by 2002:aca:48d8:: with SMTP id v207mr362654oia.113.1571171642164;
        Tue, 15 Oct 2019 13:34:02 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w20sm6884877otk.73.2019.10.15.13.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 13:34:01 -0700 (PDT)
Date:   Tue, 15 Oct 2019 15:34:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org, sean@geanix.com,
        martin@geanix.com, rjones@gateworks.com,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 12/13] dt-bindings: iio: imu: st_lsm6dsx: document
 missing wakeup-source property
Message-ID: <20191015203400.GA6162@bogus>
References: <cover.1570367532.git.lorenzo@kernel.org>
 <b0521798dfc8a64780349876fe00a2664bc1b926.1570367532.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0521798dfc8a64780349876fe00a2664bc1b926.1570367532.git.lorenzo@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  6 Oct 2019 15:22:06 +0200, Lorenzo Bianconi wrote:
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
