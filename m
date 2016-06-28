Return-Path: <gregor.boirie@parrot.com>
Message-ID: <57723851.2070403@parrot.com>
Date: Tue, 28 Jun 2016 10:41:53 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen
	<lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Denis Ciocca
	<denis.ciocca@st.com>, Giuseppe Barba <giuseppe.barba@st.com>, Crestez Dan
 Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH v2 3/7] iio:st_pressure: document sampling gains
References: <cover.1467023672.git.gregor.boirie@parrot.com> <fe513b34c179810b42a77e806347088647d17106.1467023672.git.gregor.boirie@parrot.com> <CACRpkdaDray8+HF9RcA9Kqm5bfv0yJyNOx2-xg+WT+F9ZoA19w@mail.gmail.com>
In-Reply-To: <CACRpkdaDray8+HF9RcA9Kqm5bfv0yJyNOx2-xg+WT+F9ZoA19w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Linus,

On 06/27/2016 06:44 PM, Linus Walleij wrote:
> On Mon, Jun 27, 2016 at 12:38 PM, Gregor Boirie
> <gregor.boirie@parrot.com> wrote:
>
>> Details scaling factors and offsets applied to raw temperature and pressure
>> samples.
>>
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> I try to apply the patches on top of Jonathan's 4.8a branch, but I
> fail when I get to this patch like this:
>
> $ git am 03.patch
> Applying: iio:st_pressure: document sampling gains
> error: patch failed: drivers/iio/pressure/st_pressure_core.c:28
> error: drivers/iio/pressure/st_pressure_core.c: patch does not apply
> Patch failed at 0001 iio:st_pressure: document sampling gains
> The copy of the patch that failed is found in:
>     /home/linus/linux-iio/.git/rebase-apply/patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
yep. it seems the patch "iio:st_pressure: fix sampling gains (bring 
inline with ABI)"
is not applied onto togreg branch.

>
> Can you rebase/make sure they all apply on the 4.8a or so so that
> I can test them?
>
> Or do you have a git branch I can just pull and test?
Please, find a rebase onto togreg branch with current interrupts related 
patches
applied (without the "harden interrupt handling" stuff) here :
https://github.com/grgbr/linux-iio/tree/iio-togreg-lps22hb
>
> Yours,
> Linus Walleij
