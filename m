Return-Path: <lars@metafoo.de>
Message-ID: <51927E9F.70405@metafoo.de>
Date: Tue, 14 May 2013 20:12:47 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: jic23@kernel.org, j.anaszewski@samsung.com,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio:common: Common library modifications to support
 pressure sensors
References: <1368541323-27423-1-git-send-email-denis.ciocca@st.com> <1368541323-27423-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1368541323-27423-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/14/2013 04:21 PM, Denis CIOCCA wrote:
> This patch add function pointer to get buffer element to support
> the pressure sensors. The channel macro definition also changed.

you need to update the users of the macro in the same patch as the macro itself
