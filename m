Return-Path: <SRS0=oEzn=ZT=linaro.org=benjamin.gaignard@kernel.org>
MIME-Version: 1.0
In-Reply-To: <ea85bd0e-90c5-ca08-172f-91d48e35f369@metafoo.de>
References: <1486390912-24362-1-git-send-email-benjamin.gaignard@st.com> <ea85bd0e-90c5-ca08-172f-91d48e35f369@metafoo.de>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Mon, 6 Feb 2017 15:43:27 +0100
Message-ID: <CA+M3ks5DzaXwmnnoin9kVUtV+sX5wXiiDz54=c541Huggi4a-Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] iio: Add parent_trigger attribute to triggers
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Fabrice Gasnier <fabrice.gasnier@st.com>,
	Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2017-02-06 15:26 GMT+01:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 02/06/2017 03:21 PM, Benjamin Gaignard wrote:
>> Thoses patches add parent_trigger attribute to IIO triggers.
>> The goal is to allow triggers to use triggers like is this done for iio
>> devices.
>> With this patch it will be possible to chain triggers, for example
>> stm32 triggers could be used as clock of an other triggers:
>> echo "tim1_trgo" > trigger0/parent_trigger.
>
> Can you explain how this is different to assigning the parent_trigger
> directly to the device?
>

It is the same but done on trigger structure without need to have an iio device.

While writing stm32 trigger driver Jonathan explain me that I can't use an iio
device without channel to chain my hardware blocks.
Since my hardware allows to chain triggers, Jonathan suggest to create this
parent_trigger attribute to ab able to link the triggers.
