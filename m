Return-Path: <afd@ti.com>
Subject: Re: [PATCH v2 4/5] iio: health: afe4404: use regmap to retrieve
 struct device
To: Jonathan Cameron <jic23@kernel.org>,
        Alison Schofield
	<amsfield22@gmail.com>
References: <cover.1460314070.git.amsfield22@gmail.com>
 <2dd23e55fa7c2d16c577146eefd4a84046d2b838.1460314070.git.amsfield22@gmail.com>
 <57129101.7000503@kernel.org>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <kgene@kernel.org>, <k.kozlowski@samsung.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <5713D0F8.20303@ti.com>
Date: Sun, 17 Apr 2016 13:07:52 -0500
MIME-Version: 1.0
In-Reply-To: <57129101.7000503@kernel.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 04/16/2016 02:22 PM, Jonathan Cameron wrote:
> On 10/04/16 20:07, Alison Schofield wrote:
>> Driver includes struct regmap and struct device in its global data.
>> Remove the struct device and use regmap API to retrieve device info.
>>

Why? This adds nothing but more code to get dev through some
container_of trickery when we could just keep a dev pointer in the data
structure.

Andrew
