Return-Path: <SRS0=dOAm=JU=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <96736265-f7ef-fff7-eb28-6a9715024e00@redhat.com>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041100360.7891@fox.voss.local> <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local> <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com>
 <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com> <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
 <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041332340.9872@fox.voss.local> <CABxcv=kL0eV9mygvX=LvqNobyyi0ySHAo1O3v2t7+q3mk_rZyA@mail.gmail.com>
 <alpine.DEB.2.20.1807041420160.9872@fox.voss.local> <CABxcv==xgZb5iyupLvFno=JNnxWnkyD8stFjACz_x756Lm2yRA@mail.gmail.com>
 <alpine.DEB.2.20.1807041501420.11004@fox.voss.local> <96736265-f7ef-fff7-eb28-6a9715024e00@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Jul 2018 19:11:54 +0300
Message-ID: <CAHp75VeNAfKF6C1RuMJgHMLDSBFH7=X9YJSzsueM7soMYSKung@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
	Javier Martinez Canillas <javier@dowhile0.org>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Xiongfeng Wang <xiongfeng.wang@linaro.org>, linux-iio <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jul 4, 2018 at 4:44 PM, Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 07/04/2018 03:24 PM, Nikolaus Voss wrote:

>> I hope you're still not annoyed...
> Don't worry for that, it's very hard to get my annoyed :)

Javier, thanks for your patience and nice explanation!

-- 
With Best Regards,
Andy Shevchenko
