Return-Path: <SRS0=ZcV1=CS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4C8C433E2
	for <linux-iio@archiver.kernel.org>; Wed,  9 Sep 2020 19:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329E521D7D
	for <linux-iio@archiver.kernel.org>; Wed,  9 Sep 2020 19:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599680198;
	bh=0mJLH0zMb+Xc7MunGZeDYcJeSCXKiggy2nvxcICF15o=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=vUttbBC33xwDv9ZD6YfGugC1Zw0nxs/imQsnC2QcpCG1U4uiB2jad4zJRADQrA0Vv
	 9RY1DxdEOa9vCyCbDf+k43hsRmwpyUJ/SOMAKXPP34QL/EyaW+Wg3rodiMq7Y471FA
	 vcy6X28yycCWyoDlrAXXzG+S0ccddh6QTyUbZhHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgIITgh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:36:37 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:40852 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgIITgg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2020 15:36:36 -0400
Received: by mail-ej1-f67.google.com with SMTP id z22so5244274ejl.7;
        Wed, 09 Sep 2020 12:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4A75QVlnD68LjJFc3DqV+1EDwANgMXhwA5DylAio9G0=;
        b=SL6lqhV+NaVaIHU0SzXCNo050LsLGA1BtCSVa08dIpeFH86cx3SlFU2ET0vjLbHqCb
         w9qKljWsWXlujEUMZ9zD0ZwV2zlWXmQdMXpa8Vm2teY20Q3bo93nu0VWc+AounRyRyBX
         6C34vKkZLWXGahXHT/JI/0vwc2gYzvvakI9JZ4scpKcrkaLI7QU5ILvSD48sNEnEhK9D
         MTSsWj9rEo1nyzHN+sCGCeRKS3OD8qd0j8cA/dh6BGtd9pR1TdFugU+XCtrmFkxkV5i+
         cO/LLgSYdbymA/nCk/j+tNF1dH0GzjEzEAh/gKeDPZVYkAHVX2QdbBXcxYqqtBC20kLU
         HVFQ==
X-Gm-Message-State: AOAM530gYtlrWMPL0ND9VKpmLsKXiMQnbr8FCmYzv/fzeRB6AeNPOVZZ
        aONuIbzvGIDcPyF3l9cg6Lk=
X-Google-Smtp-Source: ABdhPJxtHXXY+Sw0pX0gWqzTqtzsLaF2WvOGhPTGnMlRck/uiNfIm6H0iXc0JdqziBC03Pkh8jTRHw==
X-Received: by 2002:a17:906:328d:: with SMTP id 13mr5430326ejw.71.1599680193622;
        Wed, 09 Sep 2020 12:36:33 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id r8sm3517021edy.87.2020.09.09.12.36.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Sep 2020 12:36:32 -0700 (PDT)
Date:   Wed, 9 Sep 2020 21:36:30 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/25] dt-bindings: samsung: pmu: document S5Pv210
Message-ID: <20200909193630.GA21431@kozik-lap>
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907161141.31034-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 07, 2020 at 06:11:17PM +0200, Krzysztof Kozlowski wrote:
> Add compatible for the Samsung S5Pv210 SoC PMU.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 2 ++

Applied.

Best regards,
Krzysztof

