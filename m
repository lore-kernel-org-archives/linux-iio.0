Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:35465 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbbG0ORI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 10:17:08 -0400
Received: by lahh5 with SMTP id h5so49880373lah.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2015 07:17:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1438006099-3906-1-git-send-email-jasaw@dius.com.au>
References: <1438006099-3906-1-git-send-email-jasaw@dius.com.au>
Date: Mon, 27 Jul 2015 17:17:07 +0300
Message-ID: <CAEnQRZCkbGDeBUp7mXKRdM+o_GcpXHL8phscZnqLsfFXfeBV6w@mail.gmail.com>
Subject: Re: [PATCH] tools: iio: calc_digits is static
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Joo Aun Saw <jasaw@dius.com.au>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 27, 2015 at 5:08 PM, Joo Aun Saw <jasaw@dius.com.au> wrote:
> From: Joo Aun Saw <jasaw@dius.com.au>
>
> calc_digits is static, make it so.

Also, here. Preferred way for subject is:

tools: iio: iio_utils: Make calc_digits static
