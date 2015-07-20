Return-Path: <giuseppe.barba@gmail.com>
MIME-Version: 1.0
In-Reply-To: <55AC6FD0.9010403@st.com>
References: <1437038264-12936-1-git-send-email-giuseppe.barba@st.com>
	<1437038264-12936-3-git-send-email-giuseppe.barba@st.com>
	<55AB8572.3040502@kernel.org>
	<55AC6FD0.9010403@st.com>
Date: Mon, 20 Jul 2015 15:12:16 +0200
Message-ID: <CAPMRSiuRL55bWhMwEt_TqBNOoTO3=czGm4rhfBnG-HzkP8pN9A@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: st-sensors: add full scale counter field
From: Giuseppe Barba <giuseppe.barba@gmail.com>
To: Denis Ciocca <denis.ciocca@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Giuseppe BARBA <giuseppe.barba@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Denis,

2015-07-20 5:49 GMT+02:00 Denis Ciocca <denis.ciocca@st.com>:
> I didn't get the benefit of this one...Just keep one more variable in memory
> in the long array. And also forget again pressure sensors...

The intent of this was to consider the case of sensors that you haven't the
possibility to change its full scale.
I'm agree with you and I'll change the code to avoid this new field.

Thanks,
Giuseppe
