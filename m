Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38126 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbcE3MXv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 May 2016 08:23:51 -0400
Subject: Re: [RFC PATCH v1 2/9] iio:st_pressure: fix sampling gains
To: Linus Walleij <linus.walleij@linaro.org>
References: <cover.1461056711.git.gregor.boirie@parrot.com>
 <c9eb30c178e4643be23bcd09ca706b08ee69d04b.1461056711.git.gregor.boirie@parrot.com>
 <453dba90-156c-1193-4cac-41da39e16938@kernel.org>
 <CACRpkdbBj_VcojG8S8Z2wN6utojJVtMQzfAwUTbGP7zwBaQYAw@mail.gmail.com>
Cc: Gregor Boirie <gregor.boirie@parrot.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b851ba20-0a1f-b7ae-15bf-a324ee5769bd@kernel.org>
Date: Mon, 30 May 2016 13:23:46 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdbBj_VcojG8S8Z2wN6utojJVtMQzfAwUTbGP7zwBaQYAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/05/16 09:17, Linus Walleij wrote:
> On Sun, May 29, 2016 at 5:14 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> Personally I'm really beginning to
>> dislike the way these drivers have simple numeric values
>> wrapped up in defines at the top.  Would be somewhat clearer
>> if they were just inline.
> 
> I agree, I never liked it either, just kept with it since the old
> code looked like that.
> 
> Do you want gigantic patches fixing it for all sensor types?
I think we want agreement from Denis on this one as it's a major change
to a driver he's been pretty good about maintaining.

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

