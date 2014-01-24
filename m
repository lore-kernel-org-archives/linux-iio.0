Return-Path: <marcus.folkesson@gmail.com>
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: iio: adis16400: Set timestamp as the last element in
Date: Fri, 24 Jan 2014 12:24:03 +0100
Message-Id: <1390562644-25124-1-git-send-email-marcus.folkesson@gmail.com>
In-Reply-To: <marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,

This patch make sure that the timestamp element is the last element
in the iio_chan_spec.
The index values for the timestamp was hardcoded and 
in conflict with other elements (at least on adis16448).

This is a problem in iio_compute_scan_bytes(). The function is 
searching for the first element with the timestamp index.
If the found element has a lesser number of storage bits, this
is a potential buffer overflow issue.
