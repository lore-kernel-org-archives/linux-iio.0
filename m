Return-Path: <SRS0=T24/=3H=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1281C33C9E
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jan 2020 02:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C856621582
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jan 2020 02:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz2Xf4cm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgARClj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 17 Jan 2020 21:41:39 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46958 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbgARClj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jan 2020 21:41:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id f15so19783261lfl.13;
        Fri, 17 Jan 2020 18:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J+iRYmced89jcnU4Rg8VpVSibvEd7ELkbaHRbjkZCpI=;
        b=Tz2Xf4cmunY+k9YkZJ1jslRC0IwCbSBgTy5kHX23niLp3acGEdDXGxixRwavhmaegK
         Ml8zQumQG2kUpWFGzR2HQ78dvhG1dAZFJBw3BHLjSILE+Bf2anJJs1Ezn0zLlfBOa+Ph
         bLB3cTsEHI40bOrVu6HdhbOMyFBWLVd/MOY0ak8q3+fwtAVha6Wp9WUSW/91EfUcEzLb
         gTT2mn8+KTH+cAw1bY/B5SdNu902WjuRqKgm21wHP4nW/6oanqOLn/cW26hSmddpwwJd
         jXGVCPxIi+yvn5jwVW5DqouYsMgxXXqj44jieUNkjkcc1NmlpUiVAyBuIgdeJvCOOVa9
         0D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J+iRYmced89jcnU4Rg8VpVSibvEd7ELkbaHRbjkZCpI=;
        b=uO9OHvO/2JipEpTG26WzAdaMtTdjzZRAWYNYUsXRAUKuLb/+x+FyRcEBuhabdKXXas
         E9N9Dlj0yfJsEwejZ8Ze6jazh2w0Gpd7bVRXm/SStKwNGuIrqcSuBj/52cAaQdFoFIUC
         zrM6p4oXaIT7jIrMBCxxIwU9gM31plIKVFByAtUMpAJD33YtHX1DT1bJEyq+DEAFYwYd
         y1+PUeCZyJSri2yZaKpkNI01ANV+ETfEHG+PjlyNRFvrB43cO/cjLGzdse4kdvkYdoq8
         0N/3LcKTyu6cAehI00xr0GOVDsqiSQPqXcCwaiQKi3D9T3PMJg6cxk7adJIWTuZ1mKsn
         sxrQ==
X-Gm-Message-State: APjAAAVdUYM+3nPgElxje4dDYMXONe3nuD8L8Xg1fsdjG9rC+t9VrTMz
        NQZTbEsbnOrkS9boOmusKwsFgMZg
X-Google-Smtp-Source: APXvYqz9wBfKWuD4mdqswx9eJOhhQuVJz//RlPfOEqu8FWu1GCAiD0Fd6bDvTwOsz0N3JmvzPFwUKQ==
X-Received: by 2002:ac2:5e6c:: with SMTP id a12mr438297lfr.32.1579315295896;
        Fri, 17 Jan 2020 18:41:35 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id f11sm15308894lfa.9.2020.01.17.18.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 18:41:34 -0800 (PST)
Subject: Re: [PATCH v1 1/2] iio: accel: kxcjk1013: Support orientation matrix
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200112203301.30235-1-digetx@gmail.com>
 <df95e688271b4cc0e2313daeeae85507c566fc04.camel@linux.intel.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <05662b2a-829a-aa0f-d751-05f01bf6535f@gmail.com>
Date:   Sat, 18 Jan 2020 05:41:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <df95e688271b4cc0e2313daeeae85507c566fc04.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

15.01.2020 20:20, Srinivas Pandruvada пишет:
> On Sun, 2020-01-12 at 23:33 +0300, Dmitry Osipenko wrote:
>> Hardware could be physically mounted in any possible direction and
>> userpspace needs to be aware of the mounting orientation in order to
>> process sensor's data correctly. In particular this helps iio-sensor-
>> proxy
>> to report display's orientation properly on a phone/tablet devices.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks!

