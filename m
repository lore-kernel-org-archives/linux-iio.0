Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADO9-peqytsYKxVCsEbYt_fLKH3CaiAeQzfgvA+4CsP6u2yJOQ@mail.gmail.com>
References: <1461296584-11918-1-git-send-email-sdliyong@gmail.com>
	<43150fbd-37ac-2d51-dd87-f41670417b96@kernel.org>
	<571E854A.90404@gmail.com>
	<7621197a-95ed-239e-8baa-83014bc27a26@kernel.org>
	<571F49B0.4060407@metafoo.de>
	<CADO9-peu32UCxaep8yZUD6XW=ABLGiTYuQJewn-C3Gedc2JewA@mail.gmail.com>
	<571F588D.3010800@metafoo.de>
	<CADO9-peqytsYKxVCsEbYt_fLKH3CaiAeQzfgvA+4CsP6u2yJOQ@mail.gmail.com>
Date: Tue, 26 Apr 2016 18:21:39 +0300
Message-ID: <CAEnQRZCkcwDUPZHpEOTzcHxQ23xgq429fJQg63s5TUi0w69iWw@mail.gmail.com>
Subject: Re: [PATCH] iio: tmp006: Set correct iio name
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Yong Li <sdliyong@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
	Crestez Dan Leonard <cdleonard@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>,
	Matt Ranostaj <mranostay@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Apr 26, 2016 at 4:14 PM, Yong Li <sdliyong@gmail.com> wrote:
> I am thinking if there is any application is using this incorrect
> name, the application should be fix too

The rule is: "Don't break the userspace ABI". So, if we got this wrong
from the beginning we are stuck with this name.

The only thing that can save the situation is to know that there is no
application relying on the name :).
