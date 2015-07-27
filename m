Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1438005278-3439-1-git-send-email-jasaw@dius.com.au>
References: <1438005278-3439-1-git-send-email-jasaw@dius.com.au>
Date: Mon, 27 Jul 2015 17:15:56 +0300
Message-ID: <CAEnQRZD_Ogq+wDeTidcJaszD+o0_v-G4dMEaQhxT5Rk0PZqEKw@mail.gmail.com>
Subject: Re: [PATCH] tools: iio: remove unnecessary define guard from iio_utils.c
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Joo Aun Saw <jasaw@dius.com.au>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jul 27, 2015 at 4:54 PM, Joo Aun Saw <jasaw@dius.com.au> wrote:
> From: Joo Aun Saw <jasaw@dius.com.au>
>
> _IIO_UTILS_H_ define guard is unnecessary in iio_utils.c
>
> Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>

Preferred way for the commit message subject is:

tools: iio: iio_utils: remove unnecessary define guard

Other than that it looks good to me.
