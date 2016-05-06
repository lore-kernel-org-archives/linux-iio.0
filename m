Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CACRpkdYjXgh_UFV-W00y1ZzK43mtkxOLpqvqyvUEY=iaZAE2Lg@mail.gmail.com>
References: <1462535191-21131-1-git-send-email-linus.walleij@linaro.org>
	<dc142147-fffe-19ad-5c74-239ab85040b7@intel.com>
	<CACRpkdYjXgh_UFV-W00y1ZzK43mtkxOLpqvqyvUEY=iaZAE2Lg@mail.gmail.com>
Date: Fri, 6 May 2016 20:53:28 +0200
Message-ID: <CACRpkdb8rjkH74h3o3uhZ5zUf9=TFw+ucWEto+qQ2R5sMrofrA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: st_sensors: switch to a threaded interrupt
From: Linus Walleij <linus.walleij@linaro.org>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, May 6, 2016 at 8:31 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> To updates pf->timestamp I probably need to patch a new function
> into the trigger core that does only that. Will look into it.

Pfff no easy solutions there I can see. Need to reinvent triggers to
do that, the triggers have no clue what poll functions are attached to
them as it seems, they just hand out IRQs. Too bad.

I will try the approach to timestamp in the trigger then.

Yours,
Linus Walleij
