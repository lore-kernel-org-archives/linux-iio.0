Return-Path: <SRS0=2mkZ=CD=posteo.de=martink@kernel.org>
Subject: Re: [PATCH v4 1/2] iio: accel: mma8452: Rename a struct for code
 readibility
To: Harinath Nampally <harinath922@gmail.com>, jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, amsfield22@gmail.com
References: <1509904804-4608-1-git-send-email-harinath922@gmail.com>
 <1509904804-4608-2-git-send-email-harinath922@gmail.com>
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <7bb1626f-6071-753e-cb7d-885d9e293e43@posteo.de>
Date: Sun, 5 Nov 2017 21:36:25 +0100
MIME-Version: 1.0
In-Reply-To: <1509904804-4608-2-git-send-email-harinath922@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 2017-11-05 19:00, Harinath Nampally wrote:
> Rename time step look up struct to generic name
> as the values in the look table are same for all
> the other events like pulse, transient etc.
> 
> Signed-off-by: Harinath Nampally <harinath922@gmail.com>

Acked-by: Martin Kepplinger <martink@posteo.de>
