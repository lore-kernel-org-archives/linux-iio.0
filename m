Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-018.synserver.de ([212.40.185.18]:1178 "EHLO
	smtp-out-239.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753060AbbHFS7J (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Aug 2015 14:59:09 -0400
Message-ID: <55C3AE79.7000708@metafoo.de>
Date: Thu, 06 Aug 2015 20:59:05 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH] iio: st_common: use standard trigger suffix
References: <1438766895-15824-1-git-send-email-linus.walleij@linaro.org>	<9F97DF0A-7CD3-4A1B-8B41-9B060A080F47@jic23.retrosnub.co.uk> <CACRpkdauLeQbVpOiN3G6dttRKrhV4yyu_K-how-hHHXjSQN9dA@mail.gmail.com>
In-Reply-To: <CACRpkdauLeQbVpOiN3G6dttRKrhV4yyu_K-how-hHHXjSQN9dA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/06/2015 05:03 PM, Linus Walleij wrote:
[..]
> I don't know if it's a problem with generic_buffer though, is there
> another userspace that everyone is using without telling me?

Try libiio[1] and the iio_readdev[2] tool or the IIO scope[3].

- Lars

[1] https://github.com/analogdevicesinc/libiio
[2] https://github.com/analogdevicesinc/libiio/blob/master/tests/iio_readdev.c
[3] https://github.com/analogdevicesinc/iio-oscilloscope
