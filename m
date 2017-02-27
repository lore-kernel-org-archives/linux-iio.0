Return-Path: <SRS0=IHMS=2I=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] staging: iio: ad5933: move contents of header file to
 source file
To: Gargi Sharma <gs051095@gmail.com>, outreachy-kernel@googlegroups.com
References: <1488175928-15013-1-git-send-email-gs051095@gmail.com>
Cc: gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 jic23@kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <bd8f137a-b23d-f7a7-936e-78e7e9f25611@metafoo.de>
Date: Mon, 27 Feb 2017 10:22:41 +0100
MIME-Version: 1.0
In-Reply-To: <1488175928-15013-1-git-send-email-gs051095@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 02/27/2017 07:12 AM, Gargi Sharma wrote:
> The contents of the header file are used only by this single
> source file.  Move content into .c and remove .h.
> 
> Signed-off-by: Gargi Sharma <gs051095@gmail.com>

Hi,

The subject of the patch doesn't quite match th content. Anyway the platform
data should stay in the header file since it is supposed to be used outside
of the driver.
