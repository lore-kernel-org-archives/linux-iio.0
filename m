Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <fe513b34c179810b42a77e806347088647d17106.1467023672.git.gregor.boirie@parrot.com>
References: <cover.1467023672.git.gregor.boirie@parrot.com> <fe513b34c179810b42a77e806347088647d17106.1467023672.git.gregor.boirie@parrot.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Jun 2016 18:44:30 +0200
Message-ID: <CACRpkdaDray8+HF9RcA9Kqm5bfv0yJyNOx2-xg+WT+F9ZoA19w@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] iio:st_pressure: document sampling gains
To: Gregor Boirie <gregor.boirie@parrot.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>, Crestez Dan Leonard <leonard.crestez@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jun 27, 2016 at 12:38 PM, Gregor Boirie
<gregor.boirie@parrot.com> wrote:

> Details scaling factors and offsets applied to raw temperature and pressure
> samples.
>
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>

I try to apply the patches on top of Jonathan's 4.8a branch, but I
fail when I get to this patch like this:

$ git am 03.patch
Applying: iio:st_pressure: document sampling gains
error: patch failed: drivers/iio/pressure/st_pressure_core.c:28
error: drivers/iio/pressure/st_pressure_core.c: patch does not apply
Patch failed at 0001 iio:st_pressure: document sampling gains
The copy of the patch that failed is found in:
   /home/linus/linux-iio/.git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Can you rebase/make sure they all apply on the 4.8a or so so that
I can test them?

Or do you have a git branch I can just pull and test?

Yours,
Linus Walleij
