Return-Path: <SRS0=PPNF=5Z=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACRpkdaH0E9XbP5_TgENXxffPEg9fAf_UNpu8tkObZ9enm0DXA@mail.gmail.com>
References: <20170619200431.9615-1-lorenzo.bianconi@st.com>
 <20170619200431.9615-2-lorenzo.bianconi@st.com> <CACRpkdaH0E9XbP5_TgENXxffPEg9fAf_UNpu8tkObZ9enm0DXA@mail.gmail.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Tue, 20 Jun 2017 13:54:30 +0200
Message-ID: <CAA2SeNKKQM-zsg_8ieaiJbCCsjnPYgQMAds9tafiQHTyrO4fww@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: gyro: st_gyro: fix L3GD20H support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Robert Dolca <robert.dolca@intel.com>,
	Denis CIOCCA <denis.ciocca@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> On Mon, Jun 19, 2017 at 10:04 PM, Lorenzo Bianconi
> <lorenzo.bianconi83@gmail.com> wrote:
>
>> Add proper support for L3GD20H gyroscope sensor. In particular:
>> - use L3GD20H as device name instead of L3GD20
>> - fix available full scales
>> - fix available sample frequencies
>>
>> Fixes: 9444a300c2be (IIO: Add support for L3GD20H gyroscope)
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>

Hi Linus,

> Is this then fixing the issue papered over by
> commit a0657716416f834ef7710a9044614d50a36c3bdc
> "iio:gyro: bug on L3GD20H gyroscope support"
> ?
>
> Then we should probably state that as a Fixes: too.

The sensor support was introduce in 496822c78236 (iio:gyro: Add
STMicroelectronics gyroscopes driver).
Commit a0657716416 just removes the support since it was not properly done.
So what do you think?
We can add Fixes: 496822c78236 (iio:gyro: Add STMicroelectronics
gyroscopes driver).
Jonathan should I send a v2?

Regards,
Lorenzo


>
> Yours,
> Linus Walleij



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
