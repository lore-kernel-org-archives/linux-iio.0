Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45201 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbeHMSn6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Aug 2018 14:43:58 -0400
Received: by mail-ua1-f68.google.com with SMTP id k8-v6so9742035uaq.12
        for <linux-iio@vger.kernel.org>; Mon, 13 Aug 2018 09:01:07 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id q16-v6sm2582575uao.39.2018.08.13.09.01.05
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:01:05 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id m13-v6so9756840uaq.7
        for <linux-iio@vger.kernel.org>; Mon, 13 Aug 2018 09:01:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180803223801.749909f4@archlinux>
References: <1533260633-12385-1-git-send-email-smohanad@codeaurora.org> <20180803223801.749909f4@archlinux>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 13 Aug 2018 09:01:04 -0700
Message-ID: <CAD=FV=VcBiXLPHiQam+vvgUr7JdXmZNS043OPHWVCyqEP+9McA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: adc: Add QCOM SPMI PMIC5 ADC driver
To: Jonathan Cameron <jic23@kernel.org>, kirtika@chromium.org
Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Fri, Aug 3, 2018 at 2:38 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu,  2 Aug 2018 18:43:53 -0700
> Siddartha Mohanadoss <smohanad@codeaurora.org> wrote:
>
>> This patch adds support for QCOM SPMI PMIC5 family
>> of ADC driver that supports hardware based offset and
>> gain compensation. The ADC peripheral can measure both
>> voltage and current channels whose input signal is
>> connected to the PMIC ADC AMUX.
>>
>> The register set and configuration has been refreshed
>> compared to the prior QCOM PMIC ADC family. Register
>> ADC5 as part of the IIO framework.
>>
>> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> Great.  Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.

FYI that what landed in iio.git is slightly broken in that it
introduces an empty file called "," at the top level.  See:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=2c909be15f45c96d3dc6a84e56a76e5c3c7a60ae


-Doug
