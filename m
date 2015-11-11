Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1447249974-27442-1-git-send-email-giuseppe.barba@st.com>
References: <1447249974-27442-1-git-send-email-giuseppe.barba@st.com>
Date: Wed, 11 Nov 2015 16:43:59 +0200
Message-ID: <CAEnQRZBd7krhvGZ-43VJTs7dC9VkkKvQN-V2vzVDSnK6a5JfOA@mail.gmail.com>
Subject: Re: Add lis2dh12 to st-sensor driver
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Giuseppe Barba <giuseppe.barba@st.com>
Cc: Denis Ciocca <denis.ciocca@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 11, 2015 at 3:52 PM, Giuseppe Barba <giuseppe.barba@st.com> wrote:
> This little commit is intended to add the lis2dh12 support on top of st iio driver.

How did you generate this patch? :). This is supposed to be the cover letter.

git format-patch -1 --cover-letter

Anyhow, in the case of a single patch you don't need a cover letter.
