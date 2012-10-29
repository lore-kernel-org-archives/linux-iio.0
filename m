Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:55795 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751596Ab2J2I4p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 29 Oct 2012 04:56:45 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Pavel Machek <pavel@denx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"burman.yan@gmail.com" <burman.yan@gmail.com>
Date: Mon, 29 Oct 2012 09:55:46 +0100
Subject: Re: STMicroelectronics accelerometers driver.
Message-ID: <508E4492.8080000@st.com>
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de>
 <20121008195007.GA32042@elf.ucw.cz> <507338B5.60307@metafoo.de>
 <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com>
 <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com>
 <507D9EA3.4070009@metafoo.de> <5085128C.7020507@st.com>
 <50858B44.2080006@kernel.org> <5087E2A8.4070304@st.com>
 <508A7DA6.7050505@metafoo.de>
In-Reply-To: <508A7DA6.7050505@metafoo.de>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars-Peter,

I have modified the source code to apply your code review, now I would 
tell you if I attach the only new patch or the full code, as you wish.

Also I have some question for you:


> There is no a generic macro for G to MS2 in iio called IIO_G_TO_M_S_2. I
> think you can also do the conversion of G to m/s**2 at compile time when you
> initilize the gain attributes of the st_accel_fullscale strutcs
>
I don't find IIO_G_TO_M_S_2 in the framework code, but I added this 
macro in my source code. It is exatly?


> I don't think you need the fullscale attribute. This is just the same as the
> scale attribute just in a different representation, as far as I can see.
>
I think this is more useful to user because if you want change the 
fullscale you can see immediately the current fullscale without apply 
conversion manually.


> I still don't get why you need this. Can't you just power-up and down the
> device on demand?
The boot time is too different from one sensor to another, this 
introduce much delay in the single read.


> I still don't get why this has to be a pointer...
I don't understand if your point is use a pointer or use a variable or 
it is not necessary.


Thanks and best regards

Denis