Return-Path: <SRS0=+kjL=LL=linaro.org=baolin.wang@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180825094357.6425ab4a@archlinux>
References: <4a7e33457617e6f0f7c9627fe20ddd3039e4fe82.1535103920.git.baolin.wang@linaro.org>
 <cc6b76c5d660818d3ff7833ea5be4f32ed960f54.1535103920.git.baolin.wang@linaro.org>
 <20180825094357.6425ab4a@archlinux>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 28 Aug 2018 11:20:25 +0800
Message-ID: <CAMz4kuKdw9EiZ2txKuPJrHt1oeKv7ye6P8GjS=KXuaJYWRs4eQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: sc27xx: Add ADC scale calibration
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, freeman.liu@spreadtrum.com,
	Mark Brown <broonie@kernel.org>, DTML <devicetree@vger.kernel.org>,
	linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On 25 August 2018 at 16:43, Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri, 24 Aug 2018 17:53:16 +0800
> Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> This patch adds support to read calibration values from the eFuse
>> controller to calibrate the ADC channel scales, which can make ADC
>> sample data more accurate.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> This looks good to me.  I'll leave it for now though given open questions
> on patch 1 and to allow others time to comment on this if they wish -
> particularly as it includes a binding addition.

Thanks for your reviewing. But after more testing, we found one issue
when reading calibration data from efuse, which is not always 4 bytes
(sizeof(u32)). So I will change to use nvmem_cell_read() instead of
nvmem_cell_read_u32() in next version.

-- 
Baolin Wang
Best Regards
