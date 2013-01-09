Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 9 Jan 2013 12:02:38 +0100
Subject: IIO Trigger HR-Timer
Message-ID: <50ED4E4E.8030603@st.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi all,

Some time ago, I had seen one patch for hr_timer trigger for=20
asynchronous data acquisition.
A lot of customers use the asynchronous data acquisition to avoid wired=20
interrupt lines.
Can I create in st_sensors library one hr_trigger for this purpose or=20
someone add this patch to the main iio trigger code?

Thanks,
Denis=
