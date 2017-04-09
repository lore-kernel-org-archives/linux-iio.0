Return-Path: <SRS0=8m7H=3R=foxmail.com=chen.chenchacha@kernel.org>
From: Chen Guanqiao <chen.chenchacha@foxmail.com>
To: pmeerw@pmeerw.net,
	jic23@kernel.org
Cc: Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH v3 0/2] iio:meter:ade7759: use 4-digit octal permissions
Date: Sun,  9 Apr 2017 12:30:25 +0800
Message-Id: <20170409043027.13930-1-chen.chenchacha@foxmail.com>
In-Reply-To: <260495ce-b068-a5ce-6ec3-a90fdd7e2510@foxmail.com>
References: <260495ce-b068-a5ce-6ec3-a90fdd7e2510@foxmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch that fixes coding style problem.

version 3:
- update the title and patch scription
- divide the patch into two parts

version 2:
- corrected spelling error


Chen Guanqiao (2):
  iio:meter:ade7759: Removing use of deprecated macros (S_IRUGO,
    S_IWUSR, S_IXUGO)
  iio:meter:ade7759: realign the rest with opening bracket

 drivers/staging/iio/meter/ade7759.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

--
2.11.0
