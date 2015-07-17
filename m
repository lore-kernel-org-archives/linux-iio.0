Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1437118502-29625-1-git-send-email-qingsong.gou@ck-telecom.com>
References: <1437118502-29625-1-git-send-email-qingsong.gou@ck-telecom.com>
Date: Fri, 17 Jul 2015 11:21:14 +0300
Message-ID: <CAEnQRZDVsaZK_v27gTxpoMU-oE588AbhsyNUQ9K7+qz15u=dSQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add DT binding support for mmc35240
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jandy Gou <qingsong.gou@ck-telecom.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>, viorel.suman@intel.com,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jul 17, 2015 at 10:35 AM, Jandy Gou <qingsong.gou@ck-telecom.com> wrote:
> Add basic DT binding for mmc35240
> Add DT binding doc for mmc35240
>
> Jandy Gou (2):
>   iio: magnetometer: mmc35240: Add DT binding
>   iio: magnetometer: mmc35240: Add DT binding doc
>
>  .../devicetree/bindings/iio/magnetometer/mmc35240.txt       | 13 +++++++++++++
>  drivers/iio/magnetometer/mmc35240.c                         |  7 +++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mmc35240.txt

Looks good to me but you will also need to CC devicetree@vger.kernel.org.

thanks,
Daniel.
