Return-Path: <SRS0=6xQ+=R7=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3492C43381
	for <linux-iio@archiver.kernel.org>; Thu, 28 Mar 2019 16:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850F320823
	for <linux-iio@archiver.kernel.org>; Thu, 28 Mar 2019 16:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553792375;
	bh=6sUSgtGpkaaUd5nyWFk3EOUSGwmkqNPIfBZmLWlQeo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cQ5oSp+VWSiSoDSO44nsOmKvyoMvCmaHCW+CmEuQvzPuh9rCVrHqdBSY/4jN6eEHA
	 70x1++UKASHPm5fHYFupHU93OLEk2e6fdKszCzZaZaVnO4B5zsrXYUEqOWMb+FpYFG
	 f149bYjXm5oj715jaC6psndtvArsp+mIsDC4hTf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfC1Q7f (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:59:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43917 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfC1Q7f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Mar 2019 12:59:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id u15so18977452otq.10;
        Thu, 28 Mar 2019 09:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jp9KPYoaHX/iqByLl1kp9ouOY6igC0lu/72bTec5iMA=;
        b=Eaz+XQrX8Z/YaIjMZA7iBMRBhLEQTMYSKKJliq9D+eb5juuGHO7MTpPghwAvrj3pmm
         XgPf7bSI+MmxeN2hvu6ZrXk5prlYhD5XkG7UDs9LHog2WV1qcRkZjN+rN0+Wl0eUUTLs
         +b03s/bNpcDmGNE0K8QXw/Ul4ATGC8M9fPrGtpvvorFfs4q5kgGDiMwXeZHg47pvE5wM
         BdW+qyt5nknX9rkSQwqZL68J85deG5tty/KGcIb/MxjF1oZwtSosCGWrKO3SQjqItfSO
         FUeic1tvITBnk+j3hP4uQUMsIfA1zm5SDcUM8Yna7hYlHViKoQclhNfMQDd/w0JdacHy
         oKDw==
X-Gm-Message-State: APjAAAVbESL7CwXCrAJgsRRCAKCzjVyvqTc3lhgPdv9as7uOCG19SyNc
        fDh0QQkXGUpklowYAZeiLPlAGOo=
X-Google-Smtp-Source: APXvYqwIC+SL3O7yYibkeXIiKhMf5DYV2ivt0EaqFnOoN/KdYYWRj9HnEkewGSOKN5yFXjRyUhd+gQ==
X-Received: by 2002:a9d:6206:: with SMTP id g6mr31895652otj.7.1553792373963;
        Thu, 28 Mar 2019 09:59:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k65sm1758895oia.16.2019.03.28.09.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 09:59:33 -0700 (PDT)
Date:   Thu, 28 Mar 2019 11:59:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rui Miguel Silva <rui.silva@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: Re: [PATCH v5 1/6] iio: gyro: add DT bindings to fxas21002c
Message-ID: <20190328165932.GA9373@bogus>
References: <20190326101651.25056-1-rui.silva@linaro.org>
 <20190326101651.25056-2-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326101651.25056-2-rui.silva@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 Mar 2019 10:16:46 +0000, Rui Miguel Silva wrote:
> Add device tree bindings for the FXAS21002C gyroscope.
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>  .../bindings/iio/gyroscope/nxp,fxas21002c.txt | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
