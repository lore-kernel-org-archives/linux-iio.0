Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <c773de82-3e67-871e-93fd-18b3cfe3a492@kernel.org>
References: <1479330928-7208-1-git-send-email-lorenzo.bianconi@st.com> <c773de82-3e67-871e-93fd-18b3cfe3a492@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 19 Nov 2016 16:18:06 +0100
Message-ID: <CACRpkdabHPxr1J3MHY-kVZCnb42cxndmJNTXd0f2SBbE+M-UgQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: common: st_sensors: fix channel data parsing
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, lorenzo.bianconi@st.com,
	Gregor Boirie <gregor.boirie@parrot.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Nov 19, 2016 at 2:07 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 16/11/16 21:15, Lorenzo Bianconi wrote:
>> Using realbits as i2c/spi read len, when that value is not byte aligned
>> (e.g 12 bits), lead to skip msb part of out data registers.
>> Fix this taking into account scan_type.shift in addition to
>> scan_type.realbits as read length:
>>
>> read_len = DIV_ROUND_UP(realbits + shift, 8)
>>
>> This fix has been tested on 8, 12, 16, 24 bit sensors
>>
>> Fixes: e7385de5291e ("iio:st_sensors: align on storagebits boundaries")
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>
> Do highlight (typically below the --) what changes have occurred.  I'm guessing this
> was mostly about testing on the 24 bit sensor and the additions in the core file.
>
> Applied to the fixes-togreg and marked for stable.  I will probably sit on this one
> for a few days before sending upstream if anyone has any final comments on it.

Makes all kind of sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
