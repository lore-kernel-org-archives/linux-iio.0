Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Brian Lilly <brian@crystalfontz.com>,
	Brent-Crosby <brent@crystalfontz.com>, Jim Wall <jimwall@q.com>
Date: Mon, 25 Nov 2013 09:37:26 +0100
Subject: Re: [RFC PATCH 0/3] DT support for ST micro accelerometers and
 gyroscopes
Message-ID: <52930C46.801@st.com>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
 <528DF164.8060009@st.com> <20131121131402.GF1029@lukather>
 <52926901.9080004@kernel.org>
In-Reply-To: <52926901.9080004@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,
>> Yes, it is, but only for i2c as far as I'm aware, and usually the DT com=
patibles are with - as a separator (I
>> looked into the ePAPR, but couldn't get any explanations or requirements=
 on this, even though it's used in all of
>> their examples)
> In other discussions, where the defacto i2c device tree bindings have
> been followed, the conclusion has been that to change to a - from _
> would result in userspace ABI changes, so whilst no one wants _
> the discussion has concluded we can't really avoid it.
Ok, I understood the point. Thanks,

Denis=
