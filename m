Return-Path: <giuseppe.barba@gmail.com>
MIME-Version: 1.0
In-Reply-To: <55AB841F.5020306@kernel.org>
References: <1437038264-12936-1-git-send-email-giuseppe.barba@st.com>
	<1437038264-12936-2-git-send-email-giuseppe.barba@st.com>
	<55AB841F.5020306@kernel.org>
Date: Mon, 20 Jul 2015 15:04:05 +0200
Message-ID: <CAPMRSitge4LeoGHUEBxHLY81gvN6Q3cpQw0rYyDQBHLWQSLFyg@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: st-sensors: add configuration for WhoAmI address
From: Giuseppe Barba <giuseppe.barba@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

> Hmm. I'd be tempted to rename the DEFAULT WAIT ADDRESS as it's clearly
> only the default in the sense it was there first.  Still probably not
> worth the hassle..

I would prefer to be consistent with the naming convention taken by
Denis that uses the ...DEFAULT... name for other macros.
What do you think?

Regards,
Giuseppe.
