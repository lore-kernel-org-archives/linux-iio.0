Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:45100 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752175Ab2J2KiU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 29 Oct 2012 06:38:20 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Pavel Machek <pavel@denx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"burman.yan@gmail.com" <burman.yan@gmail.com>
Date: Mon, 29 Oct 2012 11:38:04 +0100
Subject: Re: STMicroelectronics accelerometers driver.
Message-ID: <508E5C8C.4070102@st.com>
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de>
 <20121008195007.GA32042@elf.ucw.cz> <507338B5.60307@metafoo.de>
 <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com>
 <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com>
 <507D9EA3.4070009@metafoo.de> <5085128C.7020507@st.com>
 <50858B44.2080006@kernel.org> <5087E2A8.4070304@st.com>
 <508A7DA6.7050505@metafoo.de> <508E4492.8080000@st.com>
 <508E48D1.3000703@metafoo.de> <508E5978.5000907@st.com>
 <508E5AD5.1040907@metafoo.de>
In-Reply-To: <508E5AD5.1040907@metafoo.de>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/2012 11:30 AM, Lars-Peter Clausen wrote:
> On 10/29/2012 11:24 AM, Denis CIOCCA wrote:
>>
>>> There is no attachment attached to this mail.
>> my was a question. You prefer I attach all source code or the last modified?
>>
>>
>>>> I don't find IIO_G_TO_M_S_2 in the framework code, but I added this
>>>> macro in my source code. It is exatly?
>>>
>>> It's in the latest IIO tree and also in staging/staging-next. The definition is
>>>
>>> +#define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) \
>>> 	/ 18000000ULL)
>>
>> Sorry but I'm lost. The relation from IIO_DEGREE_TO_RAD and IIO_G_TO_M_S_2?
>>
>
> Sorry, too early in the morning, copied the wrong line.
>
> +#define IIO_G_TO_M_S_2(g) ((g) * 980665ULL / 100000ULL)
>
> Btw. the full patch can be found here:
>   http://comments.gmane.org/gmane.linux.kernel.iio/5777
>
> - Lars
>

Ok thanks.
;)

Denis