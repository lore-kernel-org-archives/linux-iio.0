Return-Path: <SRS0=m5bt=BG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EA4C433DF
	for <linux-iio@archiver.kernel.org>; Mon, 27 Jul 2020 18:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037C32078E
	for <linux-iio@archiver.kernel.org>; Mon, 27 Jul 2020 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595874101;
	bh=NWO/04JWWRC7ZzrXV8897g0mpaDNfuGed08m6svQ79I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BhtAgKUExyz+2OFI3cpYtQOLP5NZKrAkNxKo+RjTnnWRjKoQZM3iQ0EP97IO6aA8v
	 U0KJzXY/XSWTw+BiAZAbJu48C7KxauTxqSGr0L4aRgQCqUtkkaQ9r5iTvqqAee7T/Q
	 cLA3mWKZG5w2LMTSv7UAYbeq8QBjsSWvmsKf7pqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgG0SVk (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:21:40 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38345 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbgG0SVk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 14:21:40 -0400
Received: by mail-il1-f193.google.com with SMTP id s21so13923234ilk.5;
        Mon, 27 Jul 2020 11:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PxKFsPdFzHY3vM6sHu99sZ/6dGU9yRgpHVILpUOOBXE=;
        b=P/2DmQ+k9xSMEM52EUHzYgBugJ+eh8Zd1X1lll2v9tSS1rMCLmQYfWZMkFCHSMBnHc
         v1kU12hfMeuNcplTvCQ34IA5sMZA9Z2kQQrIPMm6Y+JdRjHYipXy3/J8tc2BjDV88FXO
         jgevkKfuOtjheFXBmEDjrqd3oCEHMO0nfcbPjgqSIuk1WlDBanoBHH1xgv5bs4nnS/tD
         ZyivrwqmXMBDYYQGTxsnqorZb21ZBQuY8OILYHOvWX5ndlHBF2X9Bs00MIo12KFou9hq
         UBiBScDkTBl/rkTt4NUI5fty/11cri7qQ8d0mi6NMLHqW6UdvvaBLzpJXiEQc95zFw4o
         VXPg==
X-Gm-Message-State: AOAM530BxeOExtU1mMQLgTNDmYEe1mfyDQr+UTgYhcdwMegfejZhu6MQ
        lq9ovjPGB/9zvawAIeO0ww==
X-Google-Smtp-Source: ABdhPJxOaozbqAIHrqpvdZ6Efnkm8Dt1ns0gHMaSVZ9NIrVeq92jjANSz5RVi9ll/rDXILrJRfZRwA==
X-Received: by 2002:a92:99d9:: with SMTP id t86mr3943448ilk.221.1595874099569;
        Mon, 27 Jul 2020 11:21:39 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q1sm911551ioh.0.2020.07.27.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 11:21:38 -0700 (PDT)
Received: (nullmailer pid 651936 invoked by uid 1000);
        Mon, 27 Jul 2020 18:21:36 -0000
Date:   Mon, 27 Jul 2020 12:21:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 9/9] dt-bindings: hwmon: Add bindings for ADM1266
Message-ID: <20200727182136.GA651885@bogus>
References: <20200727161814.14076-1-alexandru.tachici@analog.com>
 <20200727161814.14076-10-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727161814.14076-10-alexandru.tachici@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Jul 2020 19:18:14 +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add bindings for the Analog Devices ADM1266 sequencer.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/hwmon/adi,adm1266.yaml           | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
