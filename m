Return-Path: <SRS0=T1c/=2H=mail.ccsf.edu=kdunne@kernel.org>
Date: Sun, 26 Feb 2017 10:38:21 -0800
From: Katie Dunne <kdunne@mail.ccsf.edu>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [RFC 0/3] staging: iio: meter: Header file maintenance
Message-ID: <cover.1488133199.git.kdunne@mail.ccsf.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Remove unnecessary definitons, collapse header file into source,
and clean up includes in implemenation.

This is an RFC because the placement of the definitions is somewhat
subjective, and I've attempted to follow examples in upstream subsystems
by placing them near their implementation.

Katie Dunne (3):
  staging: iio: meter: Remove unused definitions
  staging: iio: meter: Move header content to implementation file
  staging: iio: meter: Clean up #includes

 drivers/staging/iio/meter/ade7753.c | 70 ++++++++++++++++++++++++++++++++----
 drivers/staging/iio/meter/ade7753.h | 72 -------------------------------------
 2 files changed, 63 insertions(+), 79 deletions(-)
 delete mode 100644 drivers/staging/iio/meter/ade7753.h

-- 
2.7.4
