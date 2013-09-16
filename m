Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>, "arnd@arndb.de" <arnd@arndb.de>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Mon, 16 Sep 2013 11:21:12 +0200
Subject: Re: [PATCH 14/38] iio: accel: st: Append _accel to accelerator
 sensor device names
Message-ID: <5236CD88.10809@st.com>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-15-git-send-email-lee.jones@linaro.org>
 <52345330.4050707@kernel.org> <5234562D.5050803@kernel.org>
 <5236C259.6050701@metafoo.de>
In-Reply-To: <5236C259.6050701@metafoo.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Lars,
> On 09/14/2013 02:27 PM, Jonathan Cameron wrote:
>> On 09/14/13 13:14, Jonathan Cameron wrote:
>>> On 09/10/13 13:49, Lee Jones wrote:
>>>> Some of ST's sensors are appended with their sensor type and some
>>>> are not. For consistency we're extending the same naming convention
>>>> throughout.
>>>>
>>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> Honestly I don't care either way on these, but consistency would defini=
tely
>>> be good so applied to the togreg branch of iio.git
>>>
>>> Thanks,
>> Actually change of plan. I'm going to hold off on these as this an ABI c=
hange.
>> Iritating though having these as completely inconsistent is, changing th=
is
>> will change device identification from userspace which is not a good ide=
a.
>>
>> Sorry Lee, but we really shouldn't do this. I should have picked up on t=
his
>> in the original driver reviews but that's hindsight for you.
> I think those with the suffix are the ones where you have accel and gyro =
in
> the same package, the ones without the suffix are pure accelerometers.
Yes You are right. I've used this kind of logic... What do you think about?

Denis
